using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class GalerijaSearchObject : BaseSearchObject
    {
        public string? Opis { get;set; }
        public int? KorisnikID { get; set; }
        public bool? IncludeKorisnik { get; set; }
        public bool? isDeleted { get; set; }
    }
}
