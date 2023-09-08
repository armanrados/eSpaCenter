using AutoMapper;
using EasyNetQ;
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
    public class TerminService : BaseCRUDService<Models.Termin, Database.Termin, TerminSearchObject, TerminInsertUpdateRequest, TerminInsertUpdateRequest>,ITerminService
    {
        public TerminService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override async Task BeforeInsert(Termin entity, TerminInsertUpdateRequest insert)
        {
            entity.DatumKreiranja = DateTime.Now;
            
        }
     

        public override IQueryable<Termin> AddInclude(IQueryable<Termin> entity, TerminSearchObject search)
        {
                if(search.IncludeKorisnik == true)
                {
                        entity = entity.Include(x=> x.Korisnik);
                }
            return entity;
        }
        public override IQueryable<Termin> AddFilter(IQueryable<Termin> entity, TerminSearchObject search)
        {
            var filterQuery = base.AddFilter(entity, search);
            if (search.KorisnikID.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.KorisnikID == search.KorisnikID);
            }
            if (search.isDeleted.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.isDeleted == search.isDeleted);
            }



            return filterQuery;
        }

    }
}
