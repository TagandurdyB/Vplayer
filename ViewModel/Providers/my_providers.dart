import 'package:player/ViewModel/Providers/provider_theme.dart';
import 'package:player/ViewModel/Providers/provider_video.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProviders {
  static List<SingleChildWidget> get list => [
        ChangeNotifierProvider<ProviderTheme>(
            create: (context) => ProviderTheme()),
        ChangeNotifierProvider<ProviderVideo>(
            create: (context) => ProviderVideo()),
      ];
}
