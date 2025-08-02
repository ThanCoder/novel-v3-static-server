import 'dart:io';

import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/constants.dart';
import 'package:novel_v3_static_server/more_libs/setting/path_util.dart';

class ServerFileServices {
  static String getImagePath({bool absPath = true}) {
    final imagePath = PathUtil.createDir(
      '${getRootPath(absPath: absPath)}/images',
    );
    return imagePath;
  }

  static String getFilesPath({bool absPath = true}) {
    final imagePath = PathUtil.createDir(
      '${getRootPath(absPath: absPath)}/files',
    );
    return imagePath;
  }

  static String getContentDBFilesPath(String name, {bool absPath = true}) {
    final dirPath = PathUtil.createDir(
      '${getRootPath(absPath: absPath)}/content_db',
    );
    return '$dirPath/$name.db.json';
  }

  static String getRootPath({bool absPath = true}) {
    var rootPath = absPath ? Directory.current.path : '';
    return PathUtil.createDir('$rootPath/server');
  }

  static String getImageUrl(String name) {
    return '$serverGithubImageUrl/$name';
  }

  static String getFileUrl(String name) {
    return '$serverGithubFileUrl/$name';
  }

  static String getContentDBUrl(String name) {
    return '$serverGithubContentDBUrl/$name.db.json';
  }

  static List<String> getAccessableFiles(List<String> list) {
    list = list.where((e) {
      if (e.endsWith('.npz') || e.endsWith('.pdf')) {
        return true;
      }
      return false;
    }).toList();
    return list;
  }

  static List<String> getAccessableConfigFiles(List<String> list) {
    list = list.where((e) {
      if (e.endsWith('.config.json')) {
        return true;
      }
      return false;
    }).toList();
    return list;
  }
}
