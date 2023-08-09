﻿using AutoMapper;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class ProizvodService : BaseCRUDService<Models.Proizvod,Database.Proizvod, ProizvodSearchObject, ProizvodInsertRequest, ProizvodUpdateRequest>, IProizvodService
    {
        public ProizvodService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override IQueryable<Proizvod> AddInclude(IQueryable<Proizvod> entity, ProizvodSearchObject? search = null)
        {
            if(search?.IncludeVrstaProizvoda == true)
            {
                entity = entity.Include(x => x.VrstaProizvoda);
            }
            return entity;
        }

        public override IQueryable<Proizvod> AddFilter(IQueryable<Proizvod> entity, ProizvodSearchObject? search = null)
        {
            var filterQuery = base.AddFilter(entity, search);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filterQuery = filterQuery.Where(x => x.Naziv.ToLower().Contains(search.Naziv.ToLower()));
            }
            if (search.isDeleted.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.isDeleted == search.isDeleted);
            }


            return filterQuery;
        }

        public override async Task BeforeInsert(Proizvod entity, ProizvodInsertRequest insert)
        {
            entity.Sifra = Guid.NewGuid().ToString();

        }
        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;
        public List<Models.Proizvod> Recommend(int korisnikID)
        {
            var all = _db.Narudzbas.Include(x => x.NarudzbaProizvodis).ThenInclude(x => x.Proizvod).ToList();
            List<int> allproducts = new List<int>();
            foreach (var item in all)
            {
                foreach (var item2 in item.NarudzbaProizvodis)
                {
                    allproducts.Add(item2.ProizvodID);
                }
            }
            if (allproducts.Distinct().Count() < 2)
                return new List<Models.Proizvod>();


            var narudzbeProizvodi = _db.Narudzbas.Include(x => x.NarudzbaProizvodis).ThenInclude(x => x.Proizvod).Where(x => x.KorisnikID == korisnikID).ToList();
            if (narudzbeProizvodi.Count == 0)
                return new List<Models.Proizvod>();
            int id;
            List<int> products = new List<int>();
            foreach (var item in narudzbeProizvodi)
            {
                foreach (var item2 in item.NarudzbaProizvodis)
                {
                    products.Add(item2.ProizvodID);
                }
            }

            if (products.Distinct().Count() >= 2)
            {
                var list = products.Distinct();
                Random rand = new Random();
                int r = rand.Next(list.Count() - 1);
                id = products.ElementAt(r);
            }
            else
            {
                id = products.ElementAt(0);
            }

            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    var tmpData = _db.Narudzbas.Include("NarudzbaProizvodis").ToList();

                    var data = new List<ProductEntry>();

                    foreach (var x in tmpData)
                    {
                        if (x.NarudzbaProizvodis.Count > 1)
                        {
                            var distinctItemId = x.NarudzbaProizvodis.Select(y => y.ProizvodID).ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = x.NarudzbaProizvodis.Where(z => z.ProizvodID != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new ProductEntry()
                                    {
                                        ProductID = (uint)y,
                                        CoPurchaseProductID = (uint)z.ProizvodID,
                                    });
                                }
                            });
                        }
                    }


                    var traindata = mlContext.Data.LoadFromEnumerable(data);


                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;


                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);
                }

            }


            List<Database.Proizvod> allItems = _db.Proizvods.ToList();

            var predictionResult = new List<Tuple<Database.Proizvod, float>>();

            foreach (var item in allItems)
            {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionEngine.Predict(new ProductEntry()
                {
                    ProductID = (uint)id,
                    CoPurchaseProductID = (uint)item.ProizvodID
                });

                predictionResult.Add(new Tuple<Database.Proizvod, float>(item, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).ToList();

            return _mapper.Map<List<Models.Proizvod>>(finalResult);
        }

        public class Copurchase_prediction
        {
            public float Score { get; set; }
        }

        public class ProductEntry
        {
            [KeyType(count: 10)]
            public uint ProductID { get; set; }

            [KeyType(count: 10)]
            public uint CoPurchaseProductID { get; set; }

            public float Label { get; set; }
        }
    }

}
