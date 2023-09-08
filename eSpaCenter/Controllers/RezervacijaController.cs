using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class RezervacijaController : BaseCRUDController<Models.Rezervacija, RezervacijaSearchObject, RezervacijaInsertUpdateRequest, RezervacijaInsertUpdateRequest>
    {
        private readonly IMessageProducer _messageProducer;
        public RezervacijaController(IRezervacijaService service, IMessageProducer messageProducer) : base(service) 
        {
            _messageProducer = messageProducer;
        }
    }
}
