import 'package:flutter/material.dart';
import 'package:local_player/ViewModel/Providers/provider_controller.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class BasicOverlyWidget extends StatelessWidget {
  final bool allowScrubbing;
  const BasicOverlyWidget({super.key, this.allowScrubbing = true});

  @override
  Widget build(BuildContext context) {
    return VideoProgressIndicator(Provider.of<ControlVideo>(context).control,
        allowScrubbing: allowScrubbing);
  }
}
