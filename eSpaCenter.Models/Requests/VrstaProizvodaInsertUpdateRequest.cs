using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class VrstaProizvodaInsertUpdateRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Naziv je obavezan!")]
        public string Naziv { get; set; }
        public string Opis { get; set; }
    }
}
