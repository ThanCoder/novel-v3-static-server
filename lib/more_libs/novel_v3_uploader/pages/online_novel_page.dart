import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/online_novel_list_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/screens/novel_content_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/online_novel_services.dart';
import 'package:t_widgets/widgets/index.dart';

class OnlineNovelPage extends StatefulWidget {
  const OnlineNovelPage({super.key});

  @override
  State<OnlineNovelPage> createState() => _OnlineNovelPageState();
}

class _OnlineNovelPageState extends State<OnlineNovelPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
    super.initState();
  }

  bool isLoading = false;
  List<UploaderNovel> list = [];

  void init() async {
    try {
      setState(() {
        isLoading = true;
      });
      list = await OnlineNovelServices.instance.getNovelList();
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => OnlineNovelListItem(
                novel: list[index],
                onClicked: (novel) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NovelContentScreen(novel: novel),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
