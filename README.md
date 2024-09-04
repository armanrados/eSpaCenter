# eSpaCenter

## Credentials for Login - Desktop app
- Administrator Login
```
Username: admin
Password: admin
```
- Employees Login
```
Username: zaposlenik
Password: zaposlenik

Username: zaposlenik2
Password: zaposlenik2
```
## Credentials for Login - Mobile app
- Users Login
```
Username: user
Password: user

Username: user2
Password: user2
```
- Credit card data for stripe
```
4111 1111 1111 1111
CVC: 123  

```
## Starting the app
1. Clone repository
```
  https://github.com/armanrados/eSpaCenter.git
```
2. Open the repository in console
3. Runing the docker
```
  docker-compose build
  docker-compose up
```
4. Running the app with Visual Studio Code

- Open eSpaCenter folder

- Open UI folder

- Choose espacenter_admin folder

- Fetching dependecy
```
  flutter pub get
```
 Running the desktop app with a command
```
 flutter run -d windows
```
 
5.Running mobile app with Visual Studio Code

- Open eSpaCenter folder

- Open UI folder
  
- Choose espacenter_mobile folder
 
- Fetch dependecy
```
  flutter pub get
```
- Pokrenuti mobilni emulator

- Pokrenuti mobile aplikaciju bez debugiranja CTRL + F5

6. Pokretanje RabbitMQ kroz Visual Studio
- Odabrati eSpaCenter.Consumers kao startup project i pokrenuti ga
