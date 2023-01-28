import 'package:local_player/View/Widget/my_container.dart';
import 'package:local_player/ViewModel/Providers/provider_controller.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/Providers/provider_orientation.dart';

import '/ViewModel/Providers/provider_theme.dart';
import '/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProviders {
  static List<SingleChildWidget> get list => [
        ChangeNotifierProvider<ProviderTheme>(
            create: (context) => ProviderTheme()),
        ChangeNotifierProvider<ProviderVideo>(
            create: (context) => ProviderVideo()),
        ChangeNotifierProvider<ProviderFile>(
            create: (context) => ProviderFile()),
        ChangeNotifierProvider<ProviderOrientation>(
            create: (context) => ProviderOrientation()),
            ChangeNotifierProvider<ControlVideo>(
            create: (context) => ControlVideo()),
      ];
}
