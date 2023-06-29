using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class UslugaController : BaseCRUDController<Models.Usluga, BaseSearchObject, UslugaInsertUpdateRequest, UslugaInsertUpdateRequest>
    {
        public UslugaController(IUslugaService service) : base(service) { }
    }
}
