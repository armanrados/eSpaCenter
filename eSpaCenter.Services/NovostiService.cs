using AutoMapper;
using eSpaCenter.Models;
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
    public class NovostiService : BaseCRUDService<Models.Novosti, Database.Novosti, NovostiSearchObject, NovostiInsertRequest, NovostiUpdateRequest>, INovostiService
    {
        public NovostiService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override IQueryable<Database.Novosti> AddInclude(IQueryable<Database.Novosti> entity, NovostiSearchObject obj)
        {
            if (obj.IncludeKorisnik == true)
            {
                entity = entity.Include(x => x.Korisnik);
            }

            return entity;
        }
        public override IQueryable<Database.Novosti> AddFilter(IQueryable<Database.Novosti> entity, NovostiSearchObject obj)
        {
            if (obj.KorisnikID.HasValue)
            {
                entity = entity.Where(x => x.KorisnikID == obj.KorisnikID.Value);
            }

            if (obj.DatumOd.HasValue)
            {
                entity = entity.Where(x => x.DatumKreiranja.Date >= obj.DatumOd.Value);
            }

            if (obj.DatumDo.HasValue)
            {
                entity = entity.Where(x => x.DatumKreiranja.Date <= obj.DatumDo.Value);
            }

            return entity;
        }
    }
}
