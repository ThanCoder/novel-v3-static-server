import 'package:flutter/material.dart';
import 'ui/home_screen.dart';
import 'models/index.dart';

export 'ui/components/index.dart';
export 'models/index.dart';
export 'services/index.dart';
export 'extensions/index.dart';
export 'core/index.dart';
export 'database/index.dart';
export 'core/factory/data_source_factory.dart';

typedef OnDownloadUploaderFileCallback =
    void Function(BuildContext context, UploaderFile file);

class NovelV3Uploader {
  static final NovelV3Uploader instance = NovelV3Uploader._();
  NovelV3Uploader._();
  factory NovelV3Uploader() => instance;

  // static
  static String appLabelText = 'Static Server';
  static Widget get getHomeScreen => HomeScreen();

  // init props
  Future<String> Function(String url)? onDownloadJson;
  // init class
  // await NovelV3Uploader.instance.init
  late String Function() getCustomServerPath;
  late String Function() getRootServerUrl;
  bool isShowDebugLog = true;
  String? imageCachePath;
  List<Widget> appBarActions = [];
  OnDownloadUploaderFileCallback? onDownloadUploaderFile;

  Future<void> init({
    required String Function() getCustomServerPath,
    required String Function() getRootServerUrl,
    Future<String> Function(String url)? onDownloadJson,
    OnDownloadUploaderFileCallback? onDownloadUploaderFile,
    bool isShowDebugLog = true,
    String? imageCachePath,
    List<Widget> appBarActions = const [],
    String appLabelText = 'Static Server',
  }) async {
    this.onDownloadJson = onDownloadJson;
    this.isShowDebugLog = isShowDebugLog;
    this.getCustomServerPath = getCustomServerPath;
    this.getRootServerUrl = getRootServerUrl;
    this.imageCachePath = imageCachePath;
    this.appBarActions = appBarActions;
    this.onDownloadUploaderFile = onDownloadUploaderFile;
    NovelV3Uploader.appLabelText = appLabelText;
  }

  void showLog(String msg) {
    if (NovelV3Uploader.instance.isShowDebugLog) {
      debugPrint(msg);
    }
  }

  String get getInitLog {
    return '''
await NovelV3Uploader.instance.init(
    NovelV3Uploader.instance.onDownloadJson: (url) async {
      return '';
    },
  );''';
  }
}
