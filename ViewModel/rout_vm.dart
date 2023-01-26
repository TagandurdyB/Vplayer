
import 'package:flutter/material.dart';
import 'package:local_player/Demo/anim_arrow_page.dart';
import 'package:local_player/Demo/demo_my_sheed.dart';
import '../Demo/demo_player_nex.dart';
import '../View/Page/logo_page.dart';
import '../View/Page/main_page.dart';
import '../View/Page/page_local_player.dart';

class Rout {
  static const String pageLogo = "/LogoPage";
  static const String pageMain = "/MainPage";
  static const String pagePlayer = "/PlayerPage";
  static const String pageLocalPlayer = "/LocalPlayerPage";
  static const String pageDemoAnimArrow = "/DemoPageAnimArrow";
  static const String pageDemoVideoSheed = "/DemoPageVideoSheed";
  static const String pageDemoNexPlayer = "/DemoPageNextPlayer";

  static Map<String, Widget Function(dynamic)> pages = {
    pageLogo: (context) => const LogoPage(),
    pageMain: (context) => const MainPage(),
    pageLocalPlayer: (context) => LocalPlayerPage(),
    pageDemoAnimArrow: (context) => const AnimArrowPage(),
    pageDemoVideoSheed: (context) => const MyVideoSheed(),
    pageDemoNexPlayer:(context)=>VideoDemoNext(),
  };
}
