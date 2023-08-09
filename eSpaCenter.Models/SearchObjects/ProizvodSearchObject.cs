﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class ProizvodSearchObject : BaseSearchObject
    {
        public int? VrstaProizvodaID { get; set; }
        public string? Naziv { get; set; }
        public bool? isDeleted { get; set; }

        public bool? IncludeVrstaProizvoda { get; set; }
    }
}
