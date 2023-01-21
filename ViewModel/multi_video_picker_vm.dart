import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:local_player/ViewModel/Providers/provider_file.dart';
import 'package:local_player/ViewModel/rout_vm.dart';
import 'package:provider/provider.dart';

class MultipleVideoPicker {
  Future<void> pick(context) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      files.forEach((element) {
        debugPrint("path:=${element.path}");
      });
      Provider.of<ProviderFile>(context, listen: false).changeVideos(files);
      Navigator.pushNamed(context, Rout.pageMain);
    } else {
      debugPrint("Error!!!");
      pick(context);
    }
  }

  void repick(BuildContext context,int sec) {
    Future.delayed(Duration(seconds: sec)).then((value) => pick(context));
  }
}
