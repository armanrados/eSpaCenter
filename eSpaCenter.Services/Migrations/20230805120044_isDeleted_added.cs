using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace eSpaCenter.Services.Migrations
{
    /// <inheritdoc />
    public partial class isDeleted_added : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "isVisible",
                table: "Termins",
                newName: "isDeleted");

            migrationBuilder.RenameColumn(
                name: "isVisible",
                table: "Proizvods",
                newName: "isDeleted");

            migrationBuilder.RenameColumn(
                name: "isVisible",
                table: "Novostis",
                newName: "isDeleted");

            migrationBuilder.RenameColumn(
                name: "isVisible",
                table: "Korisniks",
                newName: "isDeleted");

            migrationBuilder.RenameColumn(
                name: "isVisible",
                table: "Galerijas",
                newName: "isDeleted");

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5723));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5726));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5728));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5730));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 1,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5322), "mvYHJ9XvbKePeTl4gorRhQAP2cc=", "hTePuigD6XYX9X34BHEQqw==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 2,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5586), "bE+icQ9Z1s7iV1bWwY6fsb14d7w=", "/U8JtjfImlbJ7zrkvJpPHw==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 3,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5611), "fqO50zNze5rZVaiRx4Y7N5TJ4cs=", "xTTMOdDwJkwtn9H7l7UMlQ==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 4,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5630), "/EcWYhwnUo7GogP2zvbQtqfK8PM=", "AlxAuFiUb+DwwVCOSVr2zQ==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 5,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5685), "BSi9P8Xw/wOvY3dzhGNDZMEk1iw=", "FUOIenh1EDsMWVEV/XlkGA==" });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 1,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "cab22f57-3953-4665-aef4-4964ea2d63b3", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3074) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 2,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "0c28402d-a0dd-421a-b032-29a5331ff075", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3079) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 3,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "fb3b684d-8775-4474-b3a6-3480ea141b21", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3085) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 4,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "3b9ec92c-ab42-448f-b4c7-fbeb3ba04b90", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3089) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 5,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "9b426b63-9479-4aaf-8d13-f9586f3d79d9", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3093) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 6,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "e1236b06-0502-4c16-99d5-519b23040cc8", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3097) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 7,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "1d391b0d-0ea3-42e3-bec7-e279ebe0b64f", new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3101) });

            migrationBuilder.UpdateData(
                table: "Novostis",
                keyColumn: "NovostiID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9830));

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 1,
                column: "Sifra",
                value: "99bd094d-b79d-440e-8102-cf30bc501120");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 2,
                column: "Sifra",
                value: "8f707933-bba4-4bc5-96ef-aacb245d5c5e");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 3,
                column: "Sifra",
                value: "3434b039-e00a-4acc-8a88-9308a393fa89");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 4,
                column: "Sifra",
                value: "222a1b21-5807-4c57-a325-d062709122e2");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 5,
                column: "Sifra",
                value: "4ffd6ef1-1d55-430c-9e42-cfbd82cd0c1c");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 6,
                column: "Sifra",
                value: "0fd3eb34-2b67-4fe0-be98-53ccd7aec23b");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 7,
                column: "Sifra",
                value: "06636891-b661-4183-8a5c-3b9acf5b77fa");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 8,
                column: "Sifra",
                value: "db9332d8-bca7-478e-acc1-a7dd5c785d67");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 9,
                column: "Sifra",
                value: "a779daa3-28f2-4ec5-8508-ea1167319c86");

            migrationBuilder.UpdateData(
                table: "Recenzijas",
                keyColumn: "RecenzijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(5765));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9809));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9815));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9659));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9742));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9751));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 4,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9759));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 5,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9766));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 6,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9773));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 7,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9780));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 8,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 368, DateTimeKind.Local).AddTicks(9787));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 1,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3043));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 2,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3046));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 3,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3048));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 4,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3050));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 5,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3052));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 6,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3054));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 7,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 14, 0, 44, 369, DateTimeKind.Local).AddTicks(3056));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "isDeleted",
                table: "Termins",
                newName: "isVisible");

            migrationBuilder.RenameColumn(
                name: "isDeleted",
                table: "Proizvods",
                newName: "isVisible");

            migrationBuilder.RenameColumn(
                name: "isDeleted",
                table: "Novostis",
                newName: "isVisible");

            migrationBuilder.RenameColumn(
                name: "isDeleted",
                table: "Korisniks",
                newName: "isVisible");

            migrationBuilder.RenameColumn(
                name: "isDeleted",
                table: "Galerijas",
                newName: "isVisible");

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 1,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5162));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 2,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5165));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 3,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5167));

            migrationBuilder.UpdateData(
                table: "KorisnikUlogas",
                keyColumn: "KorisnikUlogaID",
                keyValue: 4,
                column: "DatumIzmjene",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5169));

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 1,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(4774), "7XCWnTtscd4DXRFl22bUp3kcNl4=", "aP8uz00zYxasi2b135NO2w==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 2,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5053), "Eyz3hTNrB0GDOkv+OoZ9BZ5y66k=", "qrKtYet4qz1ZM8mZ12D7FA==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 3,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5077), "muFGbnzxbYlEKpKi8YVA8VjOLEc=", "pUmohEGwaGeEZNbWSLtxSQ==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 4,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5097), "sAyD6Gr3hJtdwXydHR1rKyIdjLA=", "N6XvMV8c1g8GO9Sl/e8T9Q==" });

            migrationBuilder.UpdateData(
                table: "Korisniks",
                keyColumn: "KorisnikID",
                keyValue: 5,
                columns: new[] { "DatumRodjenja", "LozinkaHash", "LozinkaSalt" },
                values: new object[] { new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5117), "wrcvBtMq+/8rk1RV/eICed7jsrk=", "RhgYqvYpYZz+MbEBalHiqg==" });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 1,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "7adcd592-19c0-43f8-b327-3efaa08748a8", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2087) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 2,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "c0693b0d-9e48-4abf-98e9-7b06effcce5d", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2093) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 3,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "e5ec096e-38ca-4cc4-8c40-dfe08cf615a6", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2105) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 4,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "82d58c49-ceef-4e2c-bd8b-46acb71197a7", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2109) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 5,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "efc06ebc-2490-495a-8082-1885ab90da4d", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2113) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 6,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "272dc3df-ebd6-41b2-84c7-33040ca6f55e", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2118) });

            migrationBuilder.UpdateData(
                table: "Narudzbas",
                keyColumn: "NarudzbaID",
                keyValue: 7,
                columns: new[] { "BrojNarudzbe", "DatumNarudzbe" },
                values: new object[] { "e0f4eb20-ead4-44ca-b4b7-d7966725195c", new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2122) });

            migrationBuilder.UpdateData(
                table: "Novostis",
                keyColumn: "NovostiID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9072));

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 1,
                column: "Sifra",
                value: "94efaf5c-0089-4baa-b8cc-d9dbd53bd3e8");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 2,
                column: "Sifra",
                value: "6985cd3d-df8e-4611-ab8f-0199ec6ec823");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 3,
                column: "Sifra",
                value: "bf49edbe-19f7-459b-b553-71346d3bb7fd");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 4,
                column: "Sifra",
                value: "afa3b3d6-a233-44bd-9281-4d25f2753f2e");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 5,
                column: "Sifra",
                value: "64d02095-4ec6-4155-a8a3-5d1f67f561c3");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 6,
                column: "Sifra",
                value: "9ba78635-ee6f-4ed6-b728-25ab21b8475c");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 7,
                column: "Sifra",
                value: "885f1426-e63a-4d7b-919e-53dd83fc3d25");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 8,
                column: "Sifra",
                value: "0dcd6372-a901-43fb-96a6-b49c0d9670b9");

            migrationBuilder.UpdateData(
                table: "Proizvods",
                keyColumn: "ProizvodID",
                keyValue: 9,
                column: "Sifra",
                value: "6cf9da92-8b13-4a4a-9048-5aa35dfde7fe");

            migrationBuilder.UpdateData(
                table: "Recenzijas",
                keyColumn: "RecenzijaID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(5203));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 1,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9052));

            migrationBuilder.UpdateData(
                table: "Rezervacijas",
                keyColumn: "RezervacijaID",
                keyValue: 2,
                column: "DatumRezervacije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9056));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 1,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(8854));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 2,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(8965));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 3,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(8977));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 4,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(8986));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 5,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(8995));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 6,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9004));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 7,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9012));

            migrationBuilder.UpdateData(
                table: "Termins",
                keyColumn: "TerminID",
                keyValue: 8,
                column: "DatumKreiranja",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 61, DateTimeKind.Local).AddTicks(9022));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 1,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2039));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 2,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2047));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 3,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2049));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 4,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2050));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 5,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2052));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 6,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2054));

            migrationBuilder.UpdateData(
                table: "Uplatas",
                keyColumn: "UplataID",
                keyValue: 7,
                column: "DatumTransakcije",
                value: new DateTime(2023, 8, 5, 13, 50, 30, 62, DateTimeKind.Local).AddTicks(2056));
        }
    }
}
