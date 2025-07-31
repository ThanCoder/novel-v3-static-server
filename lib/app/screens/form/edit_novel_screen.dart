import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

class EditNovelScreen extends StatefulWidget {
  UploaderNovel novel;
  EditNovelScreen({super.key, required this.novel});

  @override
  State<EditNovelScreen> createState() => _EditNovelScreenState();
}

class _EditNovelScreenState extends State<EditNovelScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final translatorController = TextEditingController();
  final mcController = TextEditingController();
  final coverUrlController = TextEditingController();
  final descController = TextEditingController();
  late UploaderNovel novel;

  @override
  void initState() {
    super.initState();
    novel = widget.novel;
    titleController.text = novel.title;
    authorController.text = novel.author;
    translatorController.text = novel.translator;
    mcController.text = novel.mc;
    coverUrlController.text = novel.coverUrl;
    descController.text = novel.desc;
  }

  void _onSaved() async {
    try {
      novel.title = titleController.text;
      novel.author = authorController.text;
      novel.translator = translatorController.text;
      novel.mc = mcController.text;
      novel.desc = descController.text;
      novel.newDate();

      // update
      await context.read<UploaderNovelServices>().update(novel);

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  List<String> get _getAllTags {
    final list = context.watch<UploaderNovelServices>().getList;
    List<String> allTags = [];
    for (var novel in list) {
      allTags.addAll(novel.getTags);
    }
    return allTags.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Novel')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              TCoverChooser(coverPath: novel.coverUrl),
              TTextField(
                label: Text('အမည်'),
                controller: titleController,
                maxLines: 1,
              ),
              TTextField(
                label: Text('ရေးသားသူ'),
                controller: authorController,
                maxLines: 1,
              ),
              TTextField(
                label: Text('ဘာသာပြန်သူ'),
                controller: translatorController,
                maxLines: 1,
              ),
              TTextField(
                label: Text('အထိက ဇောတ်ကောင်'),
                controller: mcController,
                maxLines: 1,
              ),
              // adult
              SwitchListTile.adaptive(
                title: Text('Is Adult'),
                value: novel.isAdult,
                onChanged: (value) {
                  setState(() {
                    novel.isAdult = value;
                  });
                },
              ),
              // isComplted
              SwitchListTile.adaptive(
                title: Text('Is Completed'),
                value: novel.isCompleted,
                onChanged: (value) {
                  setState(() {
                    novel.isCompleted = value;
                  });
                },
              ),
              // tags
              TTagsWrapView(
                title: 'Tags',
                values: novel.getTags,
                allTags: _getAllTags,
                onApply: (values) {
                  setState(() {
                    novel.setTags(values);
                  });
                },
              ),
              // Page Urls
              TTagsWrapView(
                title: 'Page Urls',
                values: novel.getPageUrls,
                onApply: (values) {
                  setState(() {
                    novel.setPageUrl(values);
                  });
                },
              ),
              TTextField(
                label: Text('အကြောင်းအရာ'),
                controller: descController,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaved,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
