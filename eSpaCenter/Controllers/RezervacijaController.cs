using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;
using eSpaCenter.Services.RabbitMQ;
using Microsoft.AspNetCore.Mvc;
using static eSpaCenter.Controllers.RezervacijaController;

namespace eSpaCenter.Controllers
{
    public class RezervacijaController : BaseCRUDController<Models.Rezervacija, RezervacijaSearchObject, RezervacijaInsertUpdateRequest, RezervacijaInsertUpdateRequest>
    {
        private readonly IMailProducer _rabbitMQProducer;
        public RezervacijaController(IRezervacijaService service, IMailProducer rabbitMQProducer) : base(service)
        {
            _rabbitMQProducer = rabbitMQProducer;
        }
        public class EmailModel
        {
            public string Sender { get; set; }
            public string Recipient { get; set; }
            public string Subject { get; set; }
            public string Content { get; set; }

        }
        [HttpPost("SendConfirmationEmail")]
        public IActionResult SendConfirmationEmail([FromBody] EmailModel model) 
        {
            try
            {
                _rabbitMQProducer.SendMessage(model);
                Thread.Sleep(TimeSpan.FromSeconds(15));
                return Ok();
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}
