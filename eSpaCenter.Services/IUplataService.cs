using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public interface IUplataService : ICRUDService<Models.Uplata, UplataSearchObject, UplataInsertUpdateRequest, UplataInsertUpdateRequest>
    {
    }
}
