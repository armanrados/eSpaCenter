import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSpaCenter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

 class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Column(children: [
              Image.network("https://images.ctfassets.net/4cd45et68cgf/Rx83JoRDMkYNlMC9MKzcB/2b14d5a59fc3937afd3f03191e19502d/Netflix-Symbol.png?w=700&h=456", height: 100, width: 100,),
              TextField(
                decoration: InputDecoration(labelText: "Username", prefixIcon: Icon(Icons.verified_user_rounded)),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: "Password", prefixIcon: Icon(Icons.password)),
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){ print("Radi!");},
               child: Text("Login"))
            ],),
          ),
        ),
        
        ),
    );
  }



 }
