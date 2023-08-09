using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class NovostiSearchObject : BaseSearchObject
    {
        public string? Naslov { get; set; }
        public int? KorisnikID { get; set; }
        public bool? isDeleted { get; set; }

        public bool? IncludeKorisnik { get; set; }
    }
}
