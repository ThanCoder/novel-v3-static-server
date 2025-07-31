import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/server_file_services.dart';

class EditNovelContentScreen extends StatefulWidget {
  UploaderNovel novel;
  EditNovelContentScreen({super.key, required this.novel});

  @override
  State<EditNovelContentScreen> createState() => _EditNovelContentScreenState();
}

class _EditNovelContentScreenState extends State<EditNovelContentScreen> {
  void onDragDone(DropDoneDetails details) {
    final files = details.files.map((e)=>e.path).toList();
    final filterFiles = ServerFileServices.getAccessableFiles(files);
    if(filterFiles.isEmpty) return;
    
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      enable: true,
          onDragDone: onDragDone,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.novel.title)),
        body: CustomScrollView(slivers: []),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
