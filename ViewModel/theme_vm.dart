import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'Providers/provider_theme.dart';

class MyTheme {
  final BuildContext context;
  MyTheme(this.context);

  ThemeData theme() {
    final providerTheme = Provider.of<ProviderTheme>(context);
    return ThemeData(
      textTheme: const TextTheme(
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: providerTheme.colorText,
        // displayColor: Colors.blue,
      ),
      primarySwatch: Colors.blue,
      canvasColor: providerTheme.colorCanvas,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: providerTheme.brightnessStatusBar),
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          titleTextStyle: providerTheme.styleAppBar,
          iconTheme: const IconThemeData(
            color: Colors.orange,
          )),
    );
  }
}
