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
    public class UslugaService : BaseCRUDService<Models.Usluga,Database.Usluga, BaseSearchObject, UslugaInsertUpdateRequest, UslugaInsertUpdateRequest>, IUslugaService
    {
        public UslugaService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

    }
}
