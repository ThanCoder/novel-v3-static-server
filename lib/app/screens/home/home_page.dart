import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/novel_grid_item.dart';
import 'package:novel_v3_static_server/app/components/novel_list_item.dart';
import 'package:novel_v3_static_server/app/components/novel_see_all_view.dart';
import 'package:novel_v3_static_server/app/routes_helper.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/screens/see_all_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/screens/uploader_novel_search_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/services/index.dart';
import 'package:novel_v3_static_server/more_libs/terminal_app/terminal_button.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
    super.initState();
  }

  bool isListView = false;

  void init() async {
    context.read<UploaderNovelServices>().initList();
    context.read<HelperServices>().initLocalList();
    setState(() {});
  }

  void _deleteNovelConfirm(UploaderNovel novel) {
    showDialog(
      context: context,
      builder: (context) => TConfirmDialog(
        contentText: 'ဖျက်ချင်တာ သေချာပြီလား?',
        onSubmit: () {
          context.read<UploaderNovelServices>().delete(novel);
        },
      ),
    );
  }

  void _goSeeAllScreen(String title, List<UploaderNovel> list) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeeAllScreen<UploaderNovel>(
          title: Text(title),
          list: list,
          gridItemBuilder: (context, item) => NovelGridItem(
            novel: item,
            onClicked: (novel) => goEditNovelContentScreen(context, novel),
            onRightClicked: _showMenu,
          ),
        ),
      ),
    );
  }

  void _goSearchScreen() {
    final list = context.read<UploaderNovelServices>().getList;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploaderNovelSearchScreen(
          list: list,
          listItemBuilder: (context, novel) => NovelListItem(
            novel: novel,
            onClicked: (novel) => goEditNovelContentScreen(context, novel),
            onRightClicked: _showMenu,
          ),
          onClicked: _goSeeAllScreen,
        ),
      ),
    );
  }

  void _goContentPage(UploaderNovel novel) {
    goEditNovelContentScreen(context, novel);
  }

  void _updateNovel(UploaderNovel novel) {
    goEditNovelScreen(
      context,
      novel: novel,
      onUpdated: (updatedNovel) async {
        try {
          await context.read<UploaderNovelServices>().update(updatedNovel);
          if (!mounted) return;
          // goEditNovelContentScreen(context, novel);

          showTSnackBar(context, '${updatedNovel.title} Updated');
        } catch (e) {
          if (!mounted) return;
          showTMessageDialogError(context, e.toString());
        }
      },
    );
  }

  void _showMenu(UploaderNovel novel) {
    showTModalBottomSheet(
      context,
      child: Column(
        spacing: 5,
        children: [
          ListTile(
            title: Text(novel.title, maxLines: 2, textAlign: TextAlign.center),
          ),
          ListTile(
            leading: Icon(Icons.copy_all),
            title: Text('Copy Title'),
            onTap: () {
              Navigator.pop(context);
              ThanPkg.appUtil.copyText(novel.title);
            },
          ),
          ListTile(
            leading: Icon(Icons.edit_document),
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _updateNovel(novel);
            },
          ),
          ListTile(
            iconColor: Colors.red,
            leading: Icon(Icons.delete_forever),
            title: Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              _deleteNovelConfirm(novel);
            },
          ),
        ],
      ),
    );
  }

  Widget _getListWidget(List<UploaderNovel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => NovelListItem(
        novel: list[index],
        onClicked: (novel) => goEditNovelContentScreen(context, novel),
        onRightClicked: _showMenu,
      ),
    );
  }

  Widget _getGridWidget(List<UploaderNovel> list) {
    final provider = context.watch<UploaderNovelServices>();
    final list = provider.getList;
    // final helperList = context.watch<HelperServices>().getList;

    final completedList = list.where((e) => e.isCompleted).toList();
    final ongoingList = list.where((e) => !e.isCompleted).toList();
    final adultList = list.where((e) => e.isAdult).toList();
    final needDescList = list.where((e) => e.desc.isEmpty).toList();

    return CustomScrollView(
      slivers: [
        // helper
        // SliverToBoxAdapter(
        //   child: HelperSeeAllView(
        //     title: 'အကူအညီများ',
        //     titleColor: Colors.deepOrange,
        //     list: helperList,
        //     showLines: 1,
        //     onSeeAllClicked: (title, list) {},
        //     onClicked: (helper) => goHelperEditScreen(context, helper),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: NovelSeeAllView(
            title: 'Description မထည့်ရသေးသော Novel များ',
            titleColor: Colors.lime,
            list: needDescList,
            showLines: 1,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
            onRightClicked: _showMenu,
          ),
        ),
        SliverToBoxAdapter(
          child: NovelSeeAllView(
            title: 'အသစ်များ',
            titleColor: Colors.green,
            list: list,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
            onRightClicked: _showMenu,
          ),
        ),

        SliverToBoxAdapter(
          child: NovelSeeAllView(
            title: 'ပြီးဆုံး',
            titleColor: Colors.blue,
            list: completedList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
            onRightClicked: _showMenu,
          ),
        ),
        SliverToBoxAdapter(
          child: NovelSeeAllView(
            title: 'ဘာသာပြန်နေဆဲ',
            titleColor: Colors.amber,
            list: ongoingList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
            onRightClicked: _showMenu,
          ),
        ),
        SliverToBoxAdapter(
          child: NovelSeeAllView(
            titleColor: Colors.red,
            title: '18 နှစ်အထက်',
            list: adultList,
            onSeeAllClicked: _goSeeAllScreen,
            onClicked: _goContentPage,
            onRightClicked: _showMenu,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploaderNovelServices>();
    final list = provider.getList;
    final isLoading = provider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('Local Page'),
        actions: [
          IconButton(onPressed: _goSearchScreen, icon: Icon(Icons.search)),
          TerminalButton(),
          IconButton(
            onPressed: () {
              setState(() {
                isListView = !isListView;
              });
            },
            icon: Icon(isListView ? Icons.list : Icons.grid_view),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : isListView
          ? _getListWidget(list)
          : _getGridWidget(list),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final newNovel = UploaderNovel.create();
            await context.read<UploaderNovelServices>().add(newNovel);
            if (!context.mounted) return;
            // go edit screen
            goEditNovelScreen(
              context,
              novel: newNovel,
              onUpdated: (novel) async {
                try {
                  await context.read<UploaderNovelServices>().update(novel);
                  if (!context.mounted) return;
                  goEditNovelContentScreen(context, novel);

                  showTSnackBar(context, '${novel.title} Updated');
                } catch (e) {
                  if (!context.mounted) return;
                  showTMessageDialogError(context, e.toString());
                }
              },
            );
          } catch (e) {
            if (!context.mounted) return;
            showTMessageDialogError(context, e.toString());
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
