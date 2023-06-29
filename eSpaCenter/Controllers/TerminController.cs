using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class TerminController : BaseCRUDController<Models.Termin,TerminSearchObject, TerminInsertUpdateRequest,TerminInsertUpdateRequest>
    {
        public TerminController(ITerminService service) : base(service) { }
    }
}
