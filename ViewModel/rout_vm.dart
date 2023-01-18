import 'package:flutter/material.dart';
import '../View/Page/logo_page.dart';
import '../View/Page/main_page.dart';
import '../View/Page/page_player.dart';

class Rout {
  static const String pageLogo = "/LogoPage";
  static const String pageMain = "/MainPage";
  static const String pagePlayer = "/PlayerPage";

  static Map<String, Widget Function(dynamic)> pages = {
    pageLogo: (context) => const LogoPage(),
    pageMain: (context) => const MainPage(),
    pagePlayer: (context) => const PlayerPage(),
  };
}
