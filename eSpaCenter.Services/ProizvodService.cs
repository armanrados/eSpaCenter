using AutoMapper;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
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
            if (search.VrstaProizvodaID.HasValue)
            {
                entity = entity.Where(x => x.VrstaProizvodaID == search.VrstaProizvodaID);
            }

            if (!string.IsNullOrWhiteSpace(search.Naziv))
            {
                entity = entity.Where(x => x.Naziv.ToLower().Contains(search.Naziv.ToLower()));
            }

            return entity;
        }

        public override async Task BeforeInsert(Proizvod entity, ProizvodInsertRequest insert)
        {
            entity.Sifra = Guid.NewGuid().ToString();

        }
    }
}
