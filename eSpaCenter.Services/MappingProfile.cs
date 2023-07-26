using AutoMapper;
using eSpaCenter.Models.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eSpaCenter.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile() 
        {
            CreateMap<Database.Korisnik, Models.Korisnik>();
            CreateMap<KorisnikInsertRequest, Database.Korisnik>();
            CreateMap<KorisnikUpdateRequest, Database.Korisnik>();

            CreateMap<Database.Uloga, Models.Uloga>();
            CreateMap<Database.KorisnikUloga, Models.KorisnikUloga>();



            CreateMap<Database.Novosti, Models.Novosti>();
            CreateMap<NovostiInsertRequest, Database.Novosti>();
            CreateMap<NovostiUpdateRequest, Database.Novosti>();

            CreateMap<Database.Recenzija, Models.Recenzija>();
            CreateMap<RecenzijaInsertRequest, Database.Recenzija>();
            CreateMap<RecenzijaUpdateRequest, Database.Recenzija>();

            CreateMap<Database.Termin, Models.Termin>();
            CreateMap<TerminInsertUpdateRequest, Database.Termin>();

            CreateMap<Database.Rezervacija, Models.Rezervacija>();
            CreateMap<RezervacijaInsertUpdateRequest, Database.Rezervacija>();

            CreateMap<Database.Usluga, Models.Usluga>();
            CreateMap<UslugaInsertUpdateRequest, Database.Usluga>();

            CreateMap<Database.Uloga, Models.Uloga>();
            CreateMap<UlogaInsertUpdateRequest, Database.Uloga>();

            CreateMap<Database.Proizvod, Models.Proizvod>();
            CreateMap<ProizvodInsertRequest, Database.Proizvod>();
            CreateMap<ProizvodUpdateRequest, Database.Proizvod>();

            CreateMap<Database.Narudzba, Models.Narudzba>();
            CreateMap<NarudzbaInsertRequest, Database.Narudzba>();
            CreateMap<NarudzbaUpdateRequest, Database.Narudzba>();

            CreateMap<Database.NarudzbaProizvodi, Models.NarudzbaProizvodi>();


            CreateMap<Database.Uplata, Models.Uplata>();
            CreateMap<UplataInsertUpdateRequest, Database.Uplata>();

            CreateMap<Database.Galerija, Models.Galerija>();
            CreateMap<GalerijaInsertRequest, Database.Galerija>();
            CreateMap<GalerijaUpdateRequest, Database.Galerija>();

            CreateMap<Database.VrstaProizvoda,Models.VrstaProizvoda>();
            CreateMap<VrstaProizvodaInsertUpdateRequest, Database.VrstaProizvoda>();






        }

    }
}
