using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class RezervacijaInsertUpdateRequest
    {
        [Required]
        public int KorisnikID { get; set; }
        [Required]
        public int TerminID { get; set; }
        [Required]
        public int UslugaID { get; set; }
        [Required]
        public DateTime DatumRezervacije { get; set; }
        public bool IsCanceled { get; set; }
        public bool IsCompleted { get; set; }
    }
}
