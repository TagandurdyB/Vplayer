import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';
import '/View/Scaffold/my_app_bar.dart';
import '/View/Scaffold/my_navigation_bar.dart';

class ScaffoldAll extends StatelessWidget {
  final Widget body;
  final Function? funcBackBtn;
  const ScaffoldAll({required this.body, super.key, this.funcBackBtn});
  @override
  Widget build(BuildContext context) {
    final bool  isPortrait=Provider.of<ProviderVideo>(context).isPortrait;
    return Scaffold(
      key: key,
      appBar:isPortrait? PreferredSize(
        key: key,
        preferredSize: const Size.fromHeight(60),
        child: MyAppBar(funcBackBtn: funcBackBtn),
      ):null,
      body: body,
      bottomNavigationBar:isPortrait? const MyBottomNavigationBar():null,
    );
  }
}
