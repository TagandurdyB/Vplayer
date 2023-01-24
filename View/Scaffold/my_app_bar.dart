import 'package:flutter/material.dart';
import '/ViewModel/Providers/provider_theme.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  final Function? funcBackBtn;
  const MyAppBar({super.key, this.funcBackBtn});

  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<ProviderTheme>(context);
    return AppBar(
      leading: funcBackBtn != null
          ? BackButton(onPressed: () {
              if (funcBackBtn != null) {
                funcBackBtn!();
              } else {
                Navigator.pop(context);
              }
            })
          : null,
      centerTitle: true,
      title: Text("Player", style: providerTheme.styleAppBar),
    );
  }
}
