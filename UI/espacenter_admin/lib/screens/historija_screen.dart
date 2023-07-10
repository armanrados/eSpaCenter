import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'master_screen.dart';

class HistorijaScreen extends StatefulWidget {
  const HistorijaScreen({super.key});

  @override
  State<HistorijaScreen> createState() => _HistorijaScreenState();
}

class _HistorijaScreenState extends State<HistorijaScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Historija",
      child: Text("...")
      
    );
  }
}