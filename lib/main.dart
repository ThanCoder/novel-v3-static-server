import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/my_app.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/online_novel_services.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_file_services.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:novel_v3_static_server/more_libs/setting/app_notifier.dart';
import 'package:novel_v3_static_server/more_libs/setting/setting.dart';
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

  await OnlineNovelServices.instance.init(
    onDownloadJson: (url) async {
      final res = await Dio().get(Setting.getForwardProxyUrl(url));
      return res.data.toString();
    },
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UploaderNovelServices()),
        ChangeNotifierProvider(create: (context) => UploaderFileServices()),
      ],
      child: const MyApp(),
    ),
  );
}
