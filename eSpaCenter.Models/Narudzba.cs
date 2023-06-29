﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace eSpaCenter.Models
{
    public class Narudzba
    {
        [Browsable(false)]
        public int NarudzbaID { get; set; }
        [DisplayName("Broj narudžbe")]
        public string BrojNarudzbe { get; set; }
        [Browsable(false)]
        public int KorisnikID { get; set; }
        [Browsable(false)]
        public int UplataID { get; set; }
        [DisplayName("Naručio korisnik")]
        public string KorisnikIme => $"{Korisnik?.Ime} {Korisnik?.Prezime}";
        [DisplayName("Datum narudžbe")]
        public DateTime DatumNarudzbe { get; set; }
        [DisplayName("Kupljeni proizvodi")]
        public string NarudzbaProizvodi => string.Join(", ", NarudzbaProizvodis?.Select(x => $"{x.Proizvod?.Naziv} x{x.Kolicina}")?.ToList());
        [DisplayName("Ukupna cijena")]
        public decimal UkupnaCijena => NarudzbaProizvodis.Sum(x => x.Proizvod.Cijena * x.Kolicina);
        [DisplayName("Otkazano")]
        public bool IsCanceled { get; set; } = false;
        [DisplayName("Isporučeno")]
        public bool IsShipped { get; set; } = false;
        [Browsable(false)]
        public virtual Korisnik Korisnik { get; set; }
        [Browsable(false)]
        public virtual Uplata Uplata { get; set; }
        [Browsable(false)]

        public virtual ICollection<NarudzbaProizvodi> NarudzbaProizvodis { get; set; }
    }
}
