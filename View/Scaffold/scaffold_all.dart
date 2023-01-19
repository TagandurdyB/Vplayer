import 'package:flutter/material.dart';
import 'package:player/View/Scaffold/my_app_bar.dart';
import 'package:player/View/Scaffold/my_navigation_bar.dart';

class ScaffoldAll extends StatelessWidget {
  final Widget body;
  const ScaffoldAll({required this.body, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        key: key,
        preferredSize:const Size.fromHeight(60),
        child:const MyAppBar(),
        ),
      body: body,
      bottomNavigationBar:const MyBottomNavigationBar(),
    );
  }
}