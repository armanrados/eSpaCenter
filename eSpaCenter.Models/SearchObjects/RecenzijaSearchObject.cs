using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.SearchObjects
{
    public class RecenzijaSearchObject : BaseSearchObject
    {
        public int? KorisnikID { get; set; }
        public DateTime? DatumOd { get; set; }
        public DateTime? DatumDo { get; set; }
        public bool? IsCanceled { get; set; }
        public bool? IsArchived { get; set; }
        public bool? IncludeTermin { get; set; }
        public bool? IncludeKorisnik { get; set; }
        public bool? IncludeUsluga { get; set; }
    }
}
