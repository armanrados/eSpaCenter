using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class NarudzbaUpdateRequest
    {
        [Required]
        public bool IsShipped { get; set; }
        [Required]
        public bool IsCanceled { get; set; }
    }
}
