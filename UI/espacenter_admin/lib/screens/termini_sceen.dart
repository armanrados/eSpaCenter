import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'master_screen.dart';

class TerminiScreen extends StatefulWidget {
  const TerminiScreen({super.key});

  @override
  State<TerminiScreen> createState() => _TerminiScreenState();
}

class _TerminiScreenState extends State<TerminiScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Termini",
      child: Text("...")
      
    );
  }
}
