import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:espacenter_admin/screens/proizvod_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProizvodProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSpaCenter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late ProizvodProvider _productProvider;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProizvodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Column(
              children: [
                Text("eSpaCenter"),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Icons.verified_user_rounded)),
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Password", prefixIcon: Icon(Icons.password)),
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      print("$username $password");

                      Authorization.username = username;
                      Authorization.password = password;

                      try {
                        await _productProvider.get();

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProizvodScreen(),
                        ));
                      } on Exception catch (e) {
                        showDialog(context: context, builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(onPressed: ()=> Navigator.pop(context), child: Text("Ok!"))
                          ],
                        ));
                      }
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
