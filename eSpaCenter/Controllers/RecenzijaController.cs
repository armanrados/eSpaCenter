using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class RecenzijaController : BaseCRUDController<Models.Recenzija,RecenzijaSearchObject, RecenzijaInsertRequest,RecenzijaUpdateRequest>
    {
        public RecenzijaController(IRecenzijaService service): base(service) { }
    }
}
