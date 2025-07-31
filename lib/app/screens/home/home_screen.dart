import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/routes_helper.dart';
import 'package:novel_v3_static_server/app/screens/home/home_page.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newNovel = UploaderNovel.create();
          context.read<UploaderNovelServices>().add(newNovel);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
