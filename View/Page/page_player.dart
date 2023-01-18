import 'package:flutter/material.dart';
import '../Scaffold/scaffold_all.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
      body: Container(
        height: 10,
        width: 10,
        color: Colors.black,
      ),
    );
  }
}
