import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/add_novel_screen.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_novel_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';

void goAddNovelScreen(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddNovelScreen()),
  );
}

void goEditNovelScreen(BuildContext context, UploaderNovel novel) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditNovelScreen(novel: novel)),
  );
}
