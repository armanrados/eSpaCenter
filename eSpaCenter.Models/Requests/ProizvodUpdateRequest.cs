using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class ProizvodUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Naziv je obavezan!")]
        public string Naziv { get; set; }
        [Required(ErrorMessage = "Cijena je obavezna!")]
        public decimal Cijena { get; set; }
        [Required(ErrorMessage = "Slika je obavezna!")]
        public byte[] Slika { get; set; }
        [Required]
        public string Opis { get; set; }
        [Required]
        public int VrstaProizvodaID { get; set; }
    }
}
