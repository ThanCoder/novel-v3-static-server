import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/my_app.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

void main()async {
  await TWidgets.instance.init(defaultImageAssetsPath: 'assets/cover.png');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UploaderNovelServices()),
      ],
      child: const MyApp(),
    ),
  );
}
