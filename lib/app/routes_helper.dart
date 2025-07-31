import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_novel_content_screen.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_novel_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';

void goEditNovelContentScreen(BuildContext context, UploaderNovel novel) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditNovelContentScreen(novel: novel)),
  );
}

void goEditNovelScreen(BuildContext context, UploaderNovel novel) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditNovelScreen(novel: novel)),
  );
}
