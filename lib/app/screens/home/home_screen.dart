import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/screens/home/home_page.dart';
import 'package:novel_v3_static_server/app/screens/home/more_page.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/screens/novel_v3_uploader_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [HomePage(), NovelV3UploaderHomeScreen(), MorePage()];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.blue,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(label: 'Local', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: 'Online',
            icon: Icon(Icons.cloud_download),
          ),
          BottomNavigationBarItem(
            label: 'More',
            icon: Icon(Icons.grid_view_rounded),
          ),
        ],
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
