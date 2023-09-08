using eSpaCenter.Authentication;
using eSpaCenter.Services;
using eSpaCenter.Services.Database;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme , Id = "basicAuth"}
            },
            new string[]{}
        }
    });
});
builder.Services.AddDbContext<eSpaCenterContext>(x => x.UseSqlServer(builder.Configuration.GetConnectionString("eSpaCenterDB")));
builder.Services.AddTransient<IKorisnikService, KorisnikService>();
builder.Services.AddTransient<INovostiService, NovostiService>();
builder.Services.AddTransient<IRecenzijaService, RecenzijaService>();
builder.Services.AddTransient<ITerminService, TerminService>();
builder.Services.AddTransient<IRezervacijaService, RezervacijaService>();
builder.Services.AddTransient<IUslugaService, UslugaService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();
builder.Services.AddTransient<IProizvodService, ProizvodService>();
builder.Services.AddTransient<INarudzbaService, NarudzbaService>();
builder.Services.AddTransient<IUplataService, UplataService>();
builder.Services.AddTransient<IGalerijaService, GalerijaService>();
builder.Services.AddTransient<IVrstaProizvodaService, VrstaProizvodaService>();
builder.Services.AddScoped<IMessageProducer, MessageProducer>();



builder.Services.AddAutoMapper(typeof(IKorisnikService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<eSpaCenterContext>();
    dataContext.Database.Migrate();
}
app.Run();
