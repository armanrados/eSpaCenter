using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class GalerijaInsertRequest
    {
  
        public byte[] SlikaByte { get; set; }
        public string Opis { get; set; }
        public int KorisnikID { get; set; }
        public bool isDeleted { get; set; }


    }
}
