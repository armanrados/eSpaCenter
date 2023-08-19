using AutoMapper;
using Azure.Core;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class NarudzbaService : BaseCRUDService<Models.Narudzba, Database.Narudzba, NarudzbaSearchObject, NarudzbaInsertRequest, NarudzbaUpdateRequest>, INarudzbaService
    {
        public NarudzbaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override async Task<Models.Narudzba> Insert(NarudzbaInsertRequest insert)
        {
            var entity = await base.Insert(insert);

            foreach (var proizvod in insert.ListaProizvoda)
            {
                Database.NarudzbaProizvodi Proizvod = new Database.NarudzbaProizvodi();

                Proizvod.ProizvodID = proizvod.ProizvodID;
                Proizvod.Kolicina = proizvod.Kolicina;
                Proizvod.NarudzbaID = entity.NarudzbaID;

               await _db.AddAsync(Proizvod);
            }

           await _db.SaveChangesAsync();

            return entity;
        }
        public override IQueryable<Narudzba> AddInclude(IQueryable<Narudzba> entity, NarudzbaSearchObject search)
        {
            if (search.IncludeKorisnik == true)
            {
                entity = entity.Include(x => x.Korisnik);
            }

            if (search.IncludeNarudzbaProizvodi == true)
            {
                entity = entity.Include(x => x.Korisnik).Include(x => x.NarudzbaProizvodis).ThenInclude(x => x.Proizvod).ThenInclude(x => x.VrstaProizvoda);
            }

            if (search.IncludeUplata == true)
            {
                entity = entity.Include(x => x.Uplata);
            }

            return entity;
        }
        public override IQueryable<Narudzba> AddFilter(IQueryable<Narudzba> entity, NarudzbaSearchObject search)
        {
            if (!string.IsNullOrWhiteSpace(search.BrojNarudzbe))
            {
                entity = entity.Where(x => x.BrojNarudzbe.StartsWith(search.BrojNarudzbe));
            }

            if (search.KorisnikID.HasValue)
            {
                entity = entity.Where(x => x.KorisnikID == search.KorisnikID);
            }
            if (search.IsShipped.HasValue)
            {
                entity = entity.Where(x => x.IsShipped == search.IsShipped);
            }

            if (search.IsCanceled.HasValue)
            {
                entity = entity.Where(x => x.IsCanceled == search.IsCanceled);
            }

            return entity;
        }

        public override async Task BeforeInsert(Narudzba entity, NarudzbaInsertRequest insert)
        {
            entity.BrojNarudzbe = Guid.NewGuid().ToString();
            entity.IsCanceled = false;
            entity.IsShipped = false;
            entity.KorisnikID = insert.KorisnikID;
            entity.DatumNarudzbe = DateTime.Now;
            entity.UplataID = insert.UplataID;
        }
    }

   
}
