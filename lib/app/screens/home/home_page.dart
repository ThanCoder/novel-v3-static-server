import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/novel_list_item.dart';
import 'package:novel_v3_static_server/app/routes_helper.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

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

  void init() async {
    context.read<UploaderNovelServices>().initList();
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

  void _showMenu(UploaderNovel novel) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 150),
          child: Column(
            spacing: 5,
            children: [
              ListTile(
                title: Text(
                  novel.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit_document),
                title: Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  goEditNovelScreen(context, novel);
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploaderNovelServices>();
    final isLoading = provider.isLoading;
    final list = provider.getList;

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => NovelListItem(
                novel: list[index],
                onClicked: (novel) {
                  goEditNovelContentScreen(context, novel);
                },
                onRightClicked: _showMenu,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novel = UploaderNovel.create();
          await context.read<UploaderNovelServices>().add(novel);
          if (!context.mounted) return;
          goEditNovelScreen(context, novel);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
