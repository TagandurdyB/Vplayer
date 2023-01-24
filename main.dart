import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/ViewModel/Providers/my_providers.dart';
import 'package:provider/provider.dart';
import 'ViewModel/rout_vm.dart';
import 'ViewModel/theme_vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: MyProviders.list, child: const MyApp()));
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Player",
      theme: MyTheme(context).theme(),
      initialRoute: Rout.pageLogo,
      routes: Rout.pages,
    );
  }
}
