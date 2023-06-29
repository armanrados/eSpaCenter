using AutoMapper;
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
    public class RecenzijaService : BaseCRUDService<Models.Recenzija, Database.Recenzija,RecenzijaSearchObject, RecenzijaInsertRequest,RecenzijaUpdateRequest>, IRecenzijaService
    {
        public RecenzijaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override IQueryable<Recenzija> AddInclude(IQueryable<Recenzija> entity, RecenzijaSearchObject search)
        {
            if(search.IncludeKorisnik == true)
            {
                entity = entity.Include(x => x.Korisnik);
            }
            return entity;
        }
    }
}
