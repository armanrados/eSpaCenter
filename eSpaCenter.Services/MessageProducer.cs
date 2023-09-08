using RabbitMQ.Client;
using System;
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
