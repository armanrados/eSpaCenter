﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class RezervacijaSearchObject : BaseSearchObject
    {
        public int? KorisnikID { get; set; }
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo { get; set; }
        public bool? IsCanceled { get; set; }
        public bool? IsCompleted { get; set; }
        public bool? IncludeTermin { get; set; }
        public bool? IncludeKorisnik { get; set; }
        public bool? IncludeUsluga { get; set; }
    }
}
