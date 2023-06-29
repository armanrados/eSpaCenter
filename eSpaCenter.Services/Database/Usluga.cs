using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Usluga
    {
        public int UslugaID { get; set; }
        public string Naziv { get; set; } = null!;
        public string Opis { get; set; } = null!;
    }
}
