import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/my_app.dart';
import 'package:novel_v3_static_server/more_libs/desktop_exe_1.0.2/desktop_exe.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/constants.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/novel_v3_uploader.dart';
import 'package:novel_v3_static_server/more_libs/terminal_app/terminal_app.dart';
import 'package:provider/provider.dart';
import 'package:t_client/t_client.dart';
import 'package:t_widgets/t_widgets.dart';

import 'more_libs/setting_v2.0.0/setting.dart';

void main() async {
  final client = TClient();

  await Setting.instance.initSetting(
    appName: 'novel_v3_static_server',
    onSettingSaved: (context, message) {
      showTSnackBar(context, message);
      NovelServices.clearDBCache();
    },
  );

  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/cover.png',
    getDarkMode: () => appConfigNotifier.value.isDarkTheme,
    onDownloadImage: (url, savePath) async {
      // await Dio().download(Setting.getForwardProxyUrl(url), savePath);
      await client.download(
        Setting.getForwardProxyUrl(url),
        savePath: savePath,
      );
    },
  );

  await NovelV3Uploader.instance.init(
    getContentFromUrl: (url) async {
      // final res = await Dio().get(Setting.getForwardProxyUrl(url));
      final res = await client.get(Setting.getForwardProxyUrl(url));
      return res.data.toString();
    },
    getLocalServerPath: () => Setting.getAppConfig.serverRootPath,
    getApiServerUrl: () => serverGitubRootUrl,
    // imageCachePath: PathUtil.getCachePath(),
  );

  await TerminalApp.instance.init(
    getExecPath: () {
      final serverRootPath = Setting.getAppConfig.serverRootPath;
      return Directory(serverRootPath).parent.path;
    },
    getBashCommand: () =>
        "git add . && git commit -m 'update' && git push -u origin main",
  );

  // desktop icon
  await DesktopExe.instance.exportNotExists(
    name: 'Novel Static Server',
    assetsIconPath: 'assets/cover.png',
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
