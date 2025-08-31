import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/my_app.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/constants.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/novel_v3_uploader.dart';
import 'package:novel_v3_static_server/more_libs/terminal_app/terminal_app.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

import 'more_libs/setting_v2.0.0/setting.dart';

void main() async {
  await Setting.instance.initSetting(appName: 'novel_v3_static_server');

  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/cover.png',
    getDarkMode: () => appConfigNotifier.value.isDarkTheme,
    onDownloadImage: (url, savePath) async {
      await Dio().download(Setting.getForwardProxyUrl(url), savePath);
    },
  );

  await NovelV3Uploader.instance.init(
    onDownloadJson: (url) async {
      final res = await Dio().get(Setting.getForwardProxyUrl(url));
      return res.data.toString();
    },
    getCustomServerPath: () => Setting.getAppConfig.serverRootPath,
    getRootServerUrl: () => serverGitubRootUrl,
  );

  await TerminalApp.instance.init(
    getExecPath: () {
      final serverRootPath = Setting.getAppConfig.serverRootPath;
      return Directory(serverRootPath).parent.path;
    },
    getBashCommand: () =>
        "git add . && git commit -m 'update' && git push -u origin main",
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HelperServices()),
      ],
      child: const MyApp(),
    ),
  );
}
