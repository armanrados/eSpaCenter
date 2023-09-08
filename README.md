# eSpaCenter

## Kredencijali za prijavu - Desktop app
- Administrator Login
```
Username: admin
Password: admin
```
- Zaposlenici Login
```
Username: zaposlenik
Password: zaposlenik

Username: zaposlenik2
Password: zaposlenik2
```
## Kredencijali za prijavu - Mobile app
- Korisnici Login
```
Username: user
Password: user

Username: user2
Password: user2
```
- Broj kartice za plaćanje koristeći stripe
```
4111 1111 1111 1111
CVC: 123  

```
## Pokretanje aplikacija
1. Kloniranje repozitorija
```
  https://github.com/armanrados/eSpaCenter.git
```
2. Otvoriti klonirani repozitorij u konzoli
3. Pokretanje dokerizovanog API-ja i DB-a
```
  docker-compose build
  docker-compose up
```
4. Pokretanje desktop aplikacije kroz Visual Studio Code

- Otvoriti eSpaCenter folder

- Otvoriti UI folder

- Odabrati espacenter_admin folder

- Dohvatanje dependecy-a
```
  flutter pub get
```
 Pokrenuti desktop aplikaciju sa komandom 
```
 flutter run -d windows
```
 
5. Pokretanje mobile aplikacije kroz Visual Studio Code

- Otvoriti eSpaCenter folder

- Otvoriti UI folder
  
- Odabrati espacenter_mobile folder
 
- Dohvatanje dependecy-a
```
  flutter pub get
```
- Pokrenuti mobilni emulator

- Pokrenuti mobile aplikaciju bez debugiranja CTRL + F5

6. Pokretanje RabbitMQ kroz Visual Studio
- Odabrati eSpaCenter.Consumers kao startup project i pokrenuti ga
