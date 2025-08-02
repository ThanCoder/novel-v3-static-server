import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/home/home_page.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/screens/online_novel_home_screen.dart';
import 'package:novel_v3_static_server/more_libs/setting/app_setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [HomePage(), OnlineNovelHomeScreen(), AppSettingScreen()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.online_prediction)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   body: DefaultTabController(length: 2, child: HomePage()),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       final newNovel = UploaderNovel.create();
    //       context.read<UploaderNovelServices>().add(newNovel);
    //     },
    //     child: Icon(Icons.add),
    //   ),
    // );
  }
}
