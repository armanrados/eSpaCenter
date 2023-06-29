﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Narudzba
    {

        public int NarudzbaID { get; set; }
        public int UplataID { get; set; }
        public string? BrojNarudzbe { get; set; }
        public int KorisnikID { get; set; }
        public DateTime DatumNarudzbe { get; set; }
        public bool IsCanceled { get; set; } = false;
        public bool IsShipped { get; set; } = false;
        public virtual Korisnik Korisnik { get; set; } = null!;
        public virtual Uplata Uplata { get; set; } = null!;
        public virtual ICollection<NarudzbaProizvodi> NarudzbaProizvodis { get; set; }
    }
}
