import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/routes_helper.dart';
import 'package:novel_v3_static_server/app/screens/home/home_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goAddNovelScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
