// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:than_pkg/than_pkg.dart';

import 'app_notifier.dart';
import 'constants.dart';
import 'path_util.dart';

class AppConfigModel {
  bool isUseCustomPath;
  String customPath;
  bool isDarkTheme;
  //proxy
  String proxyAddress;
  String proxyPort;
  bool isUseProxyServer;
  String forwardProxyUrl;
  String browserProxyUrl;
  String hostUrl;
  String serverDirPath;

  AppConfigModel({
    required this.isUseCustomPath,
    required this.customPath,
    required this.isDarkTheme,
    required this.proxyAddress,
    required this.proxyPort,
    required this.isUseProxyServer,
    required this.forwardProxyUrl,
    required this.browserProxyUrl,
    required this.hostUrl,
    required this.serverDirPath,
  });

  factory AppConfigModel.create({
    String customPath = '',
    bool isUseCustomPath = false,
    bool isDarkTheme = false,
    bool isUseProxyServer = false,
    String proxyAddress = '',
    String proxyPort = '8080',
    String forwardProxyUrl = appForwardProxyHostUrl,
    String browserProxyUrl = appBrowserProxyHostUrl,
    String hostUrl = 'https://www.channelmyanmar.to',
    String serverDirPath = '',
  }) {
    return AppConfigModel(
      isUseCustomPath: isUseCustomPath,
      customPath: customPath,
      isDarkTheme: isDarkTheme,
      proxyAddress: proxyAddress,
      proxyPort: proxyPort,
      isUseProxyServer: isUseProxyServer,
      forwardProxyUrl: forwardProxyUrl,
      browserProxyUrl: browserProxyUrl,
      hostUrl: hostUrl,
      serverDirPath: serverDirPath,
    );
  }

  AppConfigModel copyWith({
    bool? isUseCustomPath,
    String? customPath,
    bool? isDarkTheme,
    String? proxyAddress,
    String? proxyPort,
    bool? isUseProxyServer,
    String? forwardProxyUrl,
    String? browserProxyUrl,
    String? hostUrl,
    String? serverDirPath,
  }) {
    return AppConfigModel(
      isUseCustomPath: isUseCustomPath ?? this.isUseCustomPath,
      customPath: customPath ?? this.customPath,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      proxyAddress: proxyAddress ?? this.proxyAddress,
      proxyPort: proxyPort ?? this.proxyPort,
      isUseProxyServer: isUseProxyServer ?? this.isUseProxyServer,
      forwardProxyUrl: forwardProxyUrl ?? this.forwardProxyUrl,
      browserProxyUrl: browserProxyUrl ?? this.browserProxyUrl,
      hostUrl: hostUrl ?? this.hostUrl,
      serverDirPath: serverDirPath ?? this.serverDirPath,
    );
  }

  factory AppConfigModel.get() {
    final file = File('${appConfigPathNotifier.value}/$appConfigFileName');
    if (!file.existsSync()) {
      return AppConfigModel.create();
    }
    return AppConfigModel.fromMap(jsonDecode(file.readAsStringSync()));
  }

  void save() {
    PathUtil.createDir(appConfigPathNotifier.value);
    final file = File('${appConfigPathNotifier.value}/$appConfigFileName');
    String data = const JsonEncoder.withIndent('  ').convert(toMap);
    file.writeAsStringSync(data);
    appConfigNotifier.value = AppConfigModel.create();
    appConfigNotifier.value = this;
  }

  // map

  factory AppConfigModel.fromMap(Map<String, dynamic> map) {
    return AppConfigModel(
      isUseCustomPath: MapServices.get(map, [
        'is_use_custom_path',
      ], defaultValue: false),
      customPath: MapServices.get(map, ['custom_path'], defaultValue: ''),
      isDarkTheme: MapServices.get(map, ['is_dark_theme'], defaultValue: false),
      //proxy
      proxyAddress: MapServices.get(map, ['proxy_address'], defaultValue: ''),
      proxyPort: MapServices.get(map, ['proxy_port'], defaultValue: '8080'),
      isUseProxyServer: MapServices.get(map, [
        'is_use_proxy_server',
      ], defaultValue: false),
      forwardProxyUrl: MapServices.get(map, [
        'forward_proxy_url',
      ], defaultValue: appForwardProxyHostUrl),
      browserProxyUrl: MapServices.get(map, [
        'browser_proxy_url',
      ], defaultValue: appBrowserProxyHostUrl),
      hostUrl: MapServices.get(map, [
        'hostUrl',
      ], defaultValue: 'https://www.channelmyanmar.to'),
      serverDirPath: MapServices.get(map, ['serverDirPath'], defaultValue: ''),
    );
  }

  Map<String, dynamic> get toMap => {
    'is_use_custom_path': isUseCustomPath,
    'custom_path': customPath,
    'is_dark_theme': isDarkTheme,
    'proxy_address': proxyAddress,
    'proxy_port': proxyPort,
    'is_use_proxy_server': isUseProxyServer,
    'forward_proxy_url': forwardProxyUrl,
    'browser_proxy_url': browserProxyUrl,
    'hostUrl': hostUrl,
    'serverDirPath': serverDirPath,
  };
}
