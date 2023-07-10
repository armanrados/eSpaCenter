import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'master_screen.dart';

class GalerijaScreen extends StatefulWidget {
  const GalerijaScreen({super.key});

  @override
  State<GalerijaScreen> createState() => _GalerijaScreenState();
}

class _GalerijaScreenState extends State<GalerijaScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Galerija",
      child: Text("...")
      
    );
  }
}