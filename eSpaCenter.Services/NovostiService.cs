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
        public override IQueryable<Database.Novosti> AddFilter(IQueryable<Database.Novosti> entity, NovostiSearchObject search)
        {
            var filterQuery = base.AddFilter(entity, search);

            if (!string.IsNullOrWhiteSpace(search.Naslov))
            {
                filterQuery = filterQuery.Where(x => x.Naslov.ToLower().Contains(search.Naslov.ToLower()));
            }
            if (search.isDeleted.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.isDeleted == search.isDeleted);
            }



            return filterQuery;
        }
    }
}
