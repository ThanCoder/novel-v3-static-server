import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/home/home_screen.dart';
import 'package:novel_v3_static_server/more_libs/setting_v1.1.0/app_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appConfigNotifier,
      builder: (context, config, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: config.isDarkTheme ? ThemeData.dark() : null,
          home: HomeScreen(),
        );
      },
    );
  }
}
