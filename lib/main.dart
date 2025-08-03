import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/my_app.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/novel_v3_uploader.dart';
import 'package:novel_v3_static_server/more_libs/setting_v1.2.0/setting.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

void main() async {
  await Setting.initAppConfigService();

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
    getCustomServerPath: () => Setting.getAppConfig.serverDirPath,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UploaderNovelServices()),
        ChangeNotifierProvider(create: (context) => UploaderFileServices()),
        ChangeNotifierProvider(create: (context) => HelperServices()),
      ],
      child: const MyApp(),
    ),
  );
}
