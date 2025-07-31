import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';

class NovelContentScreen extends StatelessWidget {
  UploaderNovel novel;
  NovelContentScreen({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(novel.title)),
      body: Placeholder(),
    );
  }
}
