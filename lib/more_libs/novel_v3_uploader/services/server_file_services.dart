import 'dart:io';

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

  static String getRootPath({bool absPath = true}) {
    var rootPath = absPath ? Directory.current.path : '';
    return PathUtil.createDir('$rootPath/server');
  }
}
