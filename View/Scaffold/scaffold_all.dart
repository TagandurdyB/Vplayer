import 'package:flutter/material.dart';
import '/View/Scaffold/my_app_bar.dart';
import '/View/Scaffold/my_navigation_bar.dart';

class ScaffoldAll extends StatelessWidget {
  final Widget body;
  final Function? funcBackBtn;
  const ScaffoldAll({required this.body, super.key, this.funcBackBtn});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        key: key,
        preferredSize: const Size.fromHeight(60),
        child:  MyAppBar(funcBackBtn: funcBackBtn),
      ),
      body: body,
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
