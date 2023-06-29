using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class UplataController : BaseCRUDController<Models.Uplata,UplataSearchObject, UplataInsertUpdateRequest,UplataInsertUpdateRequest>
    {
        public UplataController(IUplataService service) : base(service) { }
    }
}
