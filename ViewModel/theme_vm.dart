import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_player/ViewModel/screen_values.dart';
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
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.transparent),
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
        sliderTheme:  SliderThemeData(
          showValueIndicator: ShowValueIndicator.always,
          valueIndicatorTextStyle:const TextStyle(color: Colors.white),
          valueIndicatorColor: Colors.red,
          overlayColor: Colors.white38,
          activeTrackColor: Colors.white70,
          thumbColor: Colors.white,
           thumbShape: RoundSliderThumbShape(enabledThumbRadius: Screen().width*0.03),
        ));
  }
}
