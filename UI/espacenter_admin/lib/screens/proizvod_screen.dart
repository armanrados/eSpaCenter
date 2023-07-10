import 'package:espacenter_admin/providers/proizvod_provider.dart';
import 'package:espacenter_admin/screens/master_screen.dart';
import 'package:espacenter_admin/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProizvodScreen extends StatefulWidget {
  const ProizvodScreen({super.key});

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {

  late ProizvodProvider _proizvodProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
   _proizvodProvider = context.read<ProizvodProvider>();
  } 


  @override
  Widget build(BuildContext context) {
    return MasterScreen(
       title: "Proizvodi",
      child: Container(
        child: Column(
          children: [
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _proizvodProvider.get();
                print(data);
              },
              child: Text("Click here"))
        ]),
      ),
     
    );
  }
}
