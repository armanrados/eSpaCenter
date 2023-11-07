using AutoMapper;
using Azure.Core;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class RezervacijaService : BaseCRUDService<Models.Rezervacija,Database.Rezervacija,RezervacijaSearchObject,RezervacijaInsertUpdateRequest,RezervacijaInsertUpdateRequest>, IRezervacijaService
    {
        private readonly IMessageProducer _messageProducer;

        public RezervacijaService(eSpaCenterContext db, IMapper mapper, IMessageProducer messageProducer) : base(db, mapper)
        {
            _messageProducer = messageProducer;
        }

        public override async Task<Models.Rezervacija> Insert(RezervacijaInsertUpdateRequest insert)
        {
            var entity = await base.Insert(insert);
            var termin = await _db.Termins.FindAsync(entity.TerminID);
            termin.IsBooked = true;
            entity.DatumRezervacije = DateTime.Now;
            await _db.SaveChangesAsync();
            SendEmail(entity.Korisnik.Email, "Potvrda rezervacije", "Uspješno ste rezervisali termni.");

            _messageProducer.SendingMessage<Models.Rezervacija>(entity);
            return entity;
        }

        public void SendEmail(string to, string subject, string body)
        {
            try
            {
                var smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER");
                var smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT"));
                var smtpUsername = Environment.GetEnvironmentVariable("SMTP_USERNAME");
                var smtpPassword = Environment.GetEnvironmentVariable("SMTP_PASSWORD");

                var smtpClient = new SmtpClient(smtpServer);
                smtpClient.Port = smtpPort;
                smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true; // Enable SSL for secure email sending.

                var mailMessage = new MailMessage();
                mailMessage.From = new MailAddress(smtpUsername); // Use the SMTP username as the sender
                mailMessage.To.Add(to);
                mailMessage.Subject = subject;
                mailMessage.Body = body;
                mailMessage.IsBodyHtml = true; // You can set this to true if you're sending HTML emails.

                smtpClient.Send(mailMessage);
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log, retry, or throw)
                Console.WriteLine($"Error sending email: {ex.Message}");
            }
        }

        public override IQueryable<Rezervacija> AddInclude(IQueryable<Rezervacija> entity, RezervacijaSearchObject search)
        {
            if (search.IncludeTermin == true)
            {
                entity = entity.Include(x => x.Termin).ThenInclude(x => x.Korisnik);
            }

            if (search.IncludeKorisnik == true)
            {
                entity = entity.Include(y => y.Korisnik);
            }

            if (search.IncludeUsluga == true)
            {
                entity = entity.Include(y => y.Usluga);
            }

            return entity;
        }
        public override IQueryable<Rezervacija> AddFilter(IQueryable<Rezervacija> entity, RezervacijaSearchObject search)
        {
            var filterQuery = base.AddFilter(entity, search);

            if (search.KorisnikID.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.KorisnikID == search.KorisnikID);
            }

            if (!string.IsNullOrWhiteSpace(search?.TerminVrijeme))
            {
                filterQuery = filterQuery.Where(x => x.Termin.VrijemeTermina.ToLower().Contains(search.TerminVrijeme.ToLower()));
            }


            if (search.IsCanceled.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.IsCanceled == search.IsCanceled);
            }

            if (search.IsCompleted.HasValue)
            {
                filterQuery = filterQuery.Where(x => x.IsCompleted == search.IsCompleted);
            }

            return filterQuery;
        }
    }
}
