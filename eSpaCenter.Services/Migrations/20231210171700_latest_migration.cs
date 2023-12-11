using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSpaCenter.Services.Migrations
{
    /// <inheritdoc />
    public partial class latest_migration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(2035));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(2038));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(2040));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(2042));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 1,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(1490), "GQqYU6/Sg3UmiTC0gyuSiDV4DW4=", "aS75UnwGvqM3xo4NzmbKjg==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 2,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(1913), "DAcSjvS4Pj3YIOcfqBzpB4Mmwlk=", "qmCjqWq1Zn+h4dK15HBnqA==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 3,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(1938), "IlC4IciUCtBvf15/HvT4TwzF19g=", "WWzSp5j0Ayd+qH9jHA7Y1g==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 4,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(1961), "Axp4izCq8knSsavCW+n+N4Gc+lA=", "trII0tZQBFBVJkDHxEvtaw==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 5,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(1983), "U1FF61nF+WigFVgmtqwvouPZslM=", "fM+2+ZgvGqIZ4A2lrKEg1w==" });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 1,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "69d9e759-40f0-4ba9-9c8a-3dcc33cec26c", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1615) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 2,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "835e35d0-2650-4f08-bcfd-0d9ae1e342d9", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1633) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 3,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "8607dc5d-a05a-41df-b2d9-cb732972bcc2", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1637) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 4,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "cee6f10b-5b96-4c6e-b64c-0f22fc447708", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1642) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 5,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "73c7fa28-04c4-425e-aced-50898d1f19d1", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1646) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 6,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "ce1f9e25-50cd-4d36-9f5c-342d41378d2c", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1649) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 7,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "3135cc25-7eae-4dc8-be82-c4d8af926035", new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1653) });

            migrationBuilder.UpdateData(
                table: "Novostis",
                keyColumn: "NovostiID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8254));

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 1,
                column: "Sifra",
                value: "e1ca7efe-193b-4614-b081-e3080a191cc3");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 2,
                column: "Sifra",
                value: "8845fbfb-42a0-48dd-b1a1-8dfaf8c88b69");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 3,
                column: "Sifra",
                value: "0ff109e0-3d61-42d8-902f-724e55f57e56");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 4,
                column: "Sifra",
                value: "75365213-e1e9-4e0a-8499-4b93cbb67363");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 5,
                column: "Sifra",
                value: "3c08dd9a-71bd-4d2f-9625-ab4aad24d73b");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 6,
                column: "Sifra",
                value: "733ecb9d-7801-40de-acd8-889edda58f48");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 7,
                column: "Sifra",
                value: "f51a0c6a-0672-4178-95a6-6a01262e53fe");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 8,
                column: "Sifra",
                value: "ed4752d3-d4d4-47d0-a0e0-917244b87739");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 9,
                column: "Sifra",
                value: "3b820730-3b6b-452a-8058-ce6a01d6380e");

            migrationBuilder.UpdateData(
                table: "Recenzijas",
                keyColumn: "RecenzijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(2099));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8227));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumRezervacije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8234));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8029));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8137));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8145));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 4,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8152));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 5,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8159));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 6,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8166));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 7,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8173));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 8,
                column: "DatumKreiranja",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 526, DateTimeKind.Local).AddTicks(8180));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 1,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1571));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 2,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1580));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 3,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1582));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 4,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1584));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 5,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1586));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 6,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1588));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 7,
                column: "DatumTransakcije",
                value: new DateTime(2023, 12, 10, 18, 17, 0, 527, DateTimeKind.Local).AddTicks(1590));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8635));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8639));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8641));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8643));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 1,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8248), "q6DbSrpgB3pLBUp5bjZUEOOYiQE=", "Nc5WApAPH9gPtnwjajnMNQ==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 2,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8531), "KkaRuuEd/hSYwCPVTiWWwDAm1C4=", "INlKxrU6T6hdVGKYauZKBg==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 3,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8556), "AcMzT9qSDGJAxgNC1blYVGQerfA=", "zOd56NqYi+B8ABwFOScELg==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 4,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8578), "6FF24sM1rRaZ43LtTP+g5M4d/eY=", "Vgg/hBaUNz/c/tAaIHKMhw==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 5,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8598), "kQ0HY31emHac12HUYcpJRpWze+E=", "sTfSPrHSduYJzNU0Q37iyA==" });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 1,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "cde9e894-06ea-4c27-b25b-0cad7277ca9d", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6200) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 2,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "d466345c-6e76-4f31-91ce-0c8f7223cf23", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6205) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 3,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "88cb4c3b-a2e3-4bf0-9b93-cc375bbd3648", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6212) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 4,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "3e1daf47-bff3-4d16-8400-f47c06650c4a", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6216) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 5,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "8f2ccef0-613e-4e40-b84e-310714890796", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6220) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 6,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "d91b1378-a001-4555-be34-d1f0e2ee463c", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6224) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 7,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "b0801cbc-06db-47a6-9a9a-1fa3f5484ef1", new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6228) });

            migrationBuilder.UpdateData(
                table: "Novostis",
                keyColumn: "NovostiID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3235));

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 1,
                column: "Sifra",
                value: "b74c8659-8aa2-4363-b912-447001ba6b3b");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 2,
                column: "Sifra",
                value: "ce3ac01b-f7f1-45e6-a17b-c24483645e4f");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 3,
                column: "Sifra",
                value: "686de276-1b06-4df7-8e02-da5736b00d15");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 4,
                column: "Sifra",
                value: "ece0daa1-44f1-430e-a907-531139ce60a7");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 5,
                column: "Sifra",
                value: "64f27464-3cb5-402f-aba7-991cbcd66e92");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 6,
                column: "Sifra",
                value: "4870688a-4002-4740-a60c-9d469de29b5f");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 7,
                column: "Sifra",
                value: "3fe9a86e-6b79-4cac-879e-b84fccdd7b5b");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 8,
                column: "Sifra",
                value: "631ba70d-cb16-4feb-a33d-abc51af0005d");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 9,
                column: "Sifra",
                value: "eb68a8f7-25bd-43b9-9585-df5aeab16e1c");

            migrationBuilder.UpdateData(
                table: "Recenzijas",
                keyColumn: "RecenzijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 891, DateTimeKind.Local).AddTicks(8679));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3215));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3220));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3071));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3149));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3158));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 4,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3166));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 5,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3173));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 6,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3180));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 7,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3187));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 8,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(3194));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 1,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6167));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 2,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6172));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 3,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6174));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 4,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6176));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 5,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6178));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 6,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6180));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 7,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 19, 14, 19, 49, 892, DateTimeKind.Local).AddTicks(6182));
        }
    }
}
