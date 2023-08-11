using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class TerminInsertUpdateRequest
    {
        [Required]
        public DateTime DatumTermina { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Vrijeme termina je obavezno!")]
        public string VrijemeTermina { get; set; }
        [Required]
        public int KorisnikID { get; set; }
        public bool isDeleted { get; set; }
        public bool isBooked { get; set; }


    }
}
