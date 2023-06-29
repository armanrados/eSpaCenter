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
    public class GalerijaService : BaseCRUDService<Models.Galerija, Database.Galerija,GalerijaSearchObject, GalerijaInsertRequest, GalerijaUpdateRequest>, IGalerijaService
    {
        public GalerijaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override  IQueryable<Galerija> AddInclude(IQueryable<Galerija> entity, GalerijaSearchObject? search = null)
        {
            if(search.IncludeKorisnik == true)
            {
                entity = entity.Include(x => x.Korisnik);
            }
            return entity;
        }

        public override IQueryable<Galerija> AddFilter(IQueryable<Galerija> entity, GalerijaSearchObject? search = null)
        {
            if(search.KorisnikID.HasValue) 
            {
                entity = entity.Where(x => x.KorisnikID == search.KorisnikID.Value);
            }
            return entity;
        }
    }
}
