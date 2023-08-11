using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class KorisnikUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Ime je obavezno!")]
        [MinLength(2, ErrorMessage = "Ime ne moze imati manje od 2 slova")]
        public string Ime { get; set; }
        [Required]
        [MinLength(2, ErrorMessage = "Prezime ne moze imati manje od 2 slova")]
        public string Prezime { get; set; }
        [Required]
        public string Email { get; set; }
        public string Telefon { get; set; }
        public bool isDeleted { get; set; }

        public string? Uloga { get; set; }
        public int? UlogeID { get; set; }
    }
}
