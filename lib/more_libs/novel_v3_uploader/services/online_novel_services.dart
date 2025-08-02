import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/constants.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/server_file_services.dart';

class OnlineNovelServices {
  static final OnlineNovelServices instance = OnlineNovelServices._();
  OnlineNovelServices._();
  factory OnlineNovelServices() => instance;

  Future<String> Function(String url)? onDownloadJson;
  bool isShowDebugLog = false;

  Future<void> init({
    bool isShowDebugLog = true,
    Future<String> Function(String url)? onDownloadJson,
  }) async {
    this.onDownloadJson = onDownloadJson;
    this.isShowDebugLog = isShowDebugLog;
  }

  Future<List<UploaderNovel>> getNovelList() async {
    List<UploaderNovel> list = [];
    try {
      if (onDownloadJson == null) {
        throw Exception(_getInitLog);
      }

      final res = await onDownloadJson!(serverGitubDatabaseUrl);
      List<dynamic> resList = jsonDecode(res);
      list = resList.map((e) => UploaderNovel.fromMapWithUrl(e)).toList();
    } catch (e) {
      showLog(e.toString());
    }
    return list;
  }

  Future<List<UploaderFile>> getFilesList({required String novelId}) async {
    List<UploaderFile> list = [];
    try {
      if (onDownloadJson == null) {
        throw Exception(_getInitLog);
      }
      final url = ServerFileServices.getContentDBUrl(novelId);
      // print(url);
      final res = await onDownloadJson!(url);
      List<dynamic> resList = jsonDecode(res);
      list = resList.map((e) => UploaderFile.fromMap(e)).toList();
    } catch (e) {
      showLog(e.toString());
    }
    return list;
  }

  void showLog(String msg) {
    if (isShowDebugLog) {
      debugPrint(msg);
    }
  }

  String get _getInitLog {
    return '''
await OnlineNovelServices.instance.init(
    onDownloadJson: (url) async {
      return '';
    },
  );''';
  }
}
