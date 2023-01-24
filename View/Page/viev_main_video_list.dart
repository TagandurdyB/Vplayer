import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/Providers/provider_file.dart';
import '../Widget/video_card_widget.dart';

class VievMainVideoList extends StatelessWidget {
  const VievMainVideoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerF = Provider.of<ProviderFile>(context);
    return Visibility(
      visible: true,
      child: Expanded(
        flex: 6,
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: providerF.videos.length,
            itemBuilder: ((context, index) {
              return VideoCardWidget(
                obj: providerF.videos[index],
              );
            })),
      ),
    );
  }
}
