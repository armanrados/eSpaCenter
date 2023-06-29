using AutoMapper;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class VrstaProizvodaService : BaseCRUDService<Models.VrstaProizvoda,Database.VrstaProizvoda, BaseSearchObject, VrstaProizvodaInsertUpdateRequest, VrstaProizvodaInsertUpdateRequest>, IVrstaProizvodaService
    {
        public VrstaProizvodaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }
    }
}
