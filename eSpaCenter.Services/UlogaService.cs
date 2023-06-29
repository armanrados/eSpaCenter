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
    public class UlogaService : BaseCRUDService<Models.Uloga, Database.Uloga, BaseSearchObject, UlogaInsertUpdateRequest, UlogaInsertUpdateRequest>, IUlogaService
    {
        public UlogaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }
    }
}
