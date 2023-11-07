using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System;
using System.Text;

public class RabbitMQConsumer : IDisposable
{
    private readonly IConnection _connection;
    private readonly IModel _channel;
    private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "";
    private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
    private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "password";
    private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";
    public RabbitMQConsumer()
    {

        var factory = new ConnectionFactory()
        {
            HostName = _host,
            UserName = _username,
            Password = _password,
            VirtualHost = _virtualhost,
        };

        _connection = factory.CreateConnection();
        _channel = _connection.CreateModel();
        _channel.QueueDeclare(queue: "rezervacije_added", durable: true, exclusive: false);
    }

    public void StartConsuming()
    {
        Console.WriteLine("Dobrodosli!");

        var consumer = new EventingBasicConsumer(_channel);
        consumer.Received += (model, eventArgs) =>
        {
            try
            {
                var body = eventArgs.Body.ToArray();
                var emailMessage = Encoding.UTF8.GetString(body);
                Console.WriteLine($"Received email: {emailMessage}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error handling message: {ex.Message}");
                // Handle the error as needed (e.g., log, retry, or throw)
            }
        };

        _channel.BasicConsume("rezervacije_added", true, consumer);

        // You can add a mechanism to gracefully shut down the consumer when needed.
        // For example, press Ctrl+C to stop the consumer.
        Console.WriteLine("Press Ctrl+C to exit.");
        Console.CancelKeyPress += (sender, e) =>
        {
            Dispose();
        };

        Console.ReadLine(); // This is optional and can be used for waiting, but it's not needed for message consumption.
    }

    public void Dispose()
    {
        _channel.Close();
        _connection.Close();
    }

    public static void Main(string[] args)
    {
        using var consumer = new RabbitMQConsumer();
        consumer.StartConsuming();
    }
}