using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class KorisnikInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Ime je obavezno!")]
        [MinLength(2, ErrorMessage = "Ime ne moze imati manje od 2 slova")]
        public string Ime { get; set; }
        [Required]
        [MinLength(2, ErrorMessage = "Prezime ne moze imati manje od 2 slova")]
        public string Prezime { get; set; }
        [Required]
        public DateTime DatumRodjenja { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        [Required(ErrorMessage = "Korisnicko ime je obavezno!")]
        [MinLength(4, ErrorMessage = "Korisnicko ime ne moze imate manje od 4 karaktera")]
        public string KorisnickoIme { get; set; }
        [Required(ErrorMessage = "Lozinka je obavezna!")]
        [MinLength(4, ErrorMessage = "Lozinka ne moze imati manje od 4 karaktera")]
        public string Lozinka { get; set; }
        public int UlogeID { get; set; }
    }
}
