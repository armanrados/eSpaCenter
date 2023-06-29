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
    public class UplataService : BaseCRUDService<Models.Uplata, Database.Uplata, UplataSearchObject, UplataInsertUpdateRequest, UplataInsertUpdateRequest>, IUplataService
    {
        public UplataService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        public override async Task BeforeInsert(Uplata entity, UplataInsertUpdateRequest insert)
        {
            entity.DatumTransakcije = DateTime.Now;

        }
    }
}
