using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class UplataInsertUpdateRequest
    {
        public double Iznos { get; set; }
        public DateTime DatumTransakcije { get; set; }
        public string BrojTransakcije { get; set; }
    }
}
