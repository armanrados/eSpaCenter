using AutoMapper;
using Azure.Core;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class RezervacijaService : BaseCRUDService<Models.Rezervacija,Database.Rezervacija,RezervacijaSearchObject,RezervacijaInsertUpdateRequest,RezervacijaInsertUpdateRequest>, IRezervacijaService
    {

        public RezervacijaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper)
        {
        }

        public override async Task<Models.Rezervacija> Insert(RezervacijaInsertUpdateRequest insert)
        {
            var entity = await base.Insert(insert);
            var termin = await _db.Termins.FindAsync(entity.TerminID);
            termin.IsBooked = true;
            entity.DatumRezervacije = DateTime.Now;
            await _db.SaveChangesAsync();
         
            return entity;
        }

      

        public override IQueryable<Rezervacija> AddInclude(IQueryable<Rezervacija> entity, RezervacijaSearchObject search)
        {
            if (search.IncludeTermin == true)
            {
                entity = entity.Include(x => x.Termin).ThenInclude(x => x.Korisnik);
            }

            if (search.IncludeKorisnik == true)
            {
                entity = entity.Include(y => y.Korisnik);
            }

            if (search.IncludeUsluga == true)
            {
                entity = entity.Include(y => y.Usluga);
            }

            return entity;
        }
        public override IQueryable<Rezervacija> AddFilter(IQueryable<Rezervacija> entity, RezervacijaSearchObject search)
        {
            var filterQuery = base.AddFilter(entity, search);

            if (search.KorisnikID.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.KorisnikID == search.KorisnikID);
            }

            if (!string.IsNullOrWhiteSpace(search?.TerminVrijeme))
            {
                filterQuery = filterQuery.Where(x => x.Termin.VrijemeTermina.ToLower().Contains(search.TerminVrijeme.ToLower()));
            }


            if (search.IsCanceled.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.IsCanceled == search.IsCanceled);
            }

            if (search.IsCompleted.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.IsCompleted == search.IsCompleted);
            }

            return filterQuery;
        }
    }
}
