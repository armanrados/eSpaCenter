using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class TerminSearchObject : BaseSearchObject
    {
        public int? KorisnikID { get; set; }
        public bool? IsBooked { get; set; }
        public DateTime? Datum { get; set; }
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo { get; set; }

        public bool? IncludeKorisnik { get; set; }
    }
}
