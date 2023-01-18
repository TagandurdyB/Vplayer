import 'package:flutter/material.dart';
import 'package:player/ViewModel/Providers/provider_theme.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final providerTheme=Provider.of<ProviderTheme>(context);
    return AppBar(
      centerTitle: true,
      title:  Text("Player",style: providerTheme.styleAppBar),
    );
  }
}
