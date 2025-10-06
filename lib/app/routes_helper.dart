import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_file_content_screen.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_helper_screen.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_novel_content_screen.dart';
import 'package:novel_v3_static_server/app/screens/form/edit_novel_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/helper_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/uploader_file.dart';

void goEditNovelContentScreen(BuildContext context, Novel novel) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditNovelContentScreen(novel: novel),
    ),
  );
}

void goEditNovelScreen(
  BuildContext context, {
  required Novel novel,
  required void Function(Novel updatedNovel) onUpdated,
}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditNovelScreen(novel: novel, onUpdated: onUpdated),
    ),
  );
}

void goHelperEditScreen(BuildContext context, HelperFile helper) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => EditHelperScreen(helper: helper)),
  );
}

void goEditContentFileScreen(
  BuildContext context,
  UploaderFile file, {
  required void Function(UploaderFile file) onUpdated,
}) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          EditFileContentScreen(file: file, onUpdated: onUpdated),
    ),
  );
}
