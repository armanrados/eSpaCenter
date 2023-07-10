import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'master_screen.dart';

class NarudzbeScreen extends StatefulWidget {
  const NarudzbeScreen({super.key});

  @override
  State<NarudzbeScreen> createState() => _NarudzbeScreenState();
}

class _NarudzbeScreenState extends State<NarudzbeScreen> {
  @override
  Widget build(BuildContext context) {
    return  MasterScreen(
      title: "Narudžbe",
      child: Text("..")
      
    );
  }
}
