using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class UlogaController : BaseCRUDController<Models.Uloga, BaseSearchObject, UlogaInsertUpdateRequest, UlogaInsertUpdateRequest>
    {
        public UlogaController(IUlogaService service) : base(service) { }
    }
}
