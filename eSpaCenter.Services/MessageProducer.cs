using RabbitMQ.Client;
using System;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Text.Json;

namespace eSpaCenter.Services
{
    public class MessageProducer : IMessageProducer
    {
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "rabbitmq";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "password";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";
     

        private readonly IConnection _connection;
        private readonly IModel _channel;

        public MessageProducer()
        {
            var factory = new ConnectionFactory()
            {
                HostName = _host,
                UserName = _username,
                Password = _password,
                VirtualHost = _virtualhost
            };

            _connection = factory.CreateConnection();
            _channel = _connection.CreateModel();
            _channel.QueueDeclare(queue: "rezervacije_added", durable: true, exclusive: false);
        }
        public void SendingEmailMessage(string to, string subject, string body)
        {
            try
            {
                var smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER");
                var smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT"));
                var smtpUsername = Environment.GetEnvironmentVariable("SMTP_USERNAME");
                var smtpPassword = Environment.GetEnvironmentVariable("SMTP_PASSWORD");

                var message = new MailMessage();
                message.From = new MailAddress(smtpUsername);
                message.To.Add(to);
                message.Subject = subject;
                message.Body = body;
                message.IsBodyHtml = true;

                var smtpClient = new SmtpClient(smtpServer);
                smtpClient.Port = smtpPort; // Set the SMTP port according to your email provider's settings.
                smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);
                smtpClient.EnableSsl = true; // Enable SSL for secure email sending.

                smtpClient.Send(message);
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log, retry, or throw)
                Console.WriteLine($"Error sending email message: {ex.Message}");
            }
        }

        public void SendingMessage<T>(T message)
        {
            try
            {
                var jsonString = JsonSerializer.Serialize(message);
                var body = Encoding.UTF8.GetBytes(jsonString);
                _channel.BasicPublish(exchange: string.Empty, routingKey: "rezervacije_added", body: body);
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log, retry, or throw)
                Console.WriteLine($"Error sending message: {ex.Message}");
            }
        }

        public void Dispose()
        {
            _channel.Close();
            _connection.Close();
        }
    }
}
