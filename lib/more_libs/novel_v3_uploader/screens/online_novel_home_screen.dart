import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/online_novel_grid_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/online_novel_list_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/online_novel_see_all_view.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/screens/novel_content_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/screens/see_all_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/screens/uploader_novel_search_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/online_novel_services.dart';
import 'package:t_widgets/widgets/index.dart';

class OnlineNovelHomeScreen extends StatefulWidget {
  const OnlineNovelHomeScreen({super.key});

  @override
  State<OnlineNovelHomeScreen> createState() => _OnlineNovelHomeScreenState();
}

class _OnlineNovelHomeScreenState extends State<OnlineNovelHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
    super.initState();
  }

  bool isLoading = false;
  bool isListView = false;
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

  void _goContentPage(UploaderNovel novel) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NovelContentScreen(novel: novel)),
    );
  }

  void _goSeeAllScreen(String title, List<UploaderNovel> list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeeAllScreen(
          title: Text(title),
          list: list,
          gridItemBuilder: (context, item) =>
              OnlineNovelGridItem(novel: item, onClicked: _goContentPage),
        ),
      ),
    );
  }

  void _goSearchScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploaderNovelSearchScreen(
          list: list,
          listItemBuilder: (context, novel) =>
              OnlineNovelListItem(novel: novel, onClicked: _goContentPage),
          onClicked: (title, resList) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeAllScreen<UploaderNovel>(
                  title: Text(title),
                  list: resList,
                  gridItemBuilder: (context, item) => OnlineNovelGridItem(
                    novel: item,
                    onClicked: _goContentPage,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getListWidget() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) =>
          OnlineNovelListItem(novel: list[index], onClicked: _goContentPage),
    );
  }

  Widget _getGridWidget() {
    final completedList = list.where((e) => e.isCompleted).toList();
    final ongoingList = list.where((e) => !e.isCompleted).toList();
    final adultList = list.where((e) => e.isAdult).toList();
    final randomList = List.of(list);
    randomList.shuffle();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: OnlineNovelSeeAllView(
            title: 'ကျပန်း စာစဥ်များ',
            titleColor: Colors.lime,
            list: randomList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
          ),
        ),
        SliverToBoxAdapter(
          child: OnlineNovelSeeAllView(
            title: 'အသစ်များ',
            titleColor: Colors.green,
            list: list,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
          ),
        ),

        SliverToBoxAdapter(
          child: OnlineNovelSeeAllView(
            title: 'ပြီးဆုံး',
            titleColor: Colors.blue,
            list: completedList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
          ),
        ),
        SliverToBoxAdapter(
          child: OnlineNovelSeeAllView(
            title: 'ဘာသာပြန်နေဆဲ',
            titleColor: Colors.amber,
            list: ongoingList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
          ),
        ),
        SliverToBoxAdapter(
          child: OnlineNovelSeeAllView(
            titleColor: Colors.red,
            title: '18 နှစ်အထက်',
            list: adultList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Static Server'),
        actions: [
          IconButton(onPressed: _goSearchScreen, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              isListView = !isListView;
              setState(() {});
            },
            icon: Icon(isListView ? Icons.list : Icons.grid_on_sharp),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : isListView
          ? _getListWidget()
          : _getGridWidget(),
    );
  }
}
