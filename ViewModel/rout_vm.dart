import 'package:flutter/material.dart';
import 'package:local_player/View/Page/demo_page.dart';
import '../View/Page/logo_page.dart';
import '../View/Page/main_page.dart';
import '../View/Page/page_local_player.dart';

class Rout {
  static const String pageLogo = "/LogoPage";
  static const String pageMain = "/MainPage";
  static const String pagePlayer = "/PlayerPage";
  static const String pageLocalPlayer = "/LocalPlayerPage";
  static const String pageDemo = "/DemoPage";
  static Map<String, Widget Function(dynamic)> pages = {
    pageLogo: (context) => const LogoPage(),
    pageMain: (context) => const MainPage(),
    pageLocalPlayer: (context) => LocalPlayerPage(),
    pageDemo: (context) => DemoPage(),
  };
}
