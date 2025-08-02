import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/server_file_services.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_novel_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/extensions/index.dart';
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

  void onDragDone(DropDoneDetails details) async {
    try {
      final files = details.files.map((e) => e.path).toList();
      final filterFiles = ServerFileServices.getAccessableConfigFiles(files);
      if (filterFiles.isEmpty) return;
      // move file
      final config = UploaderNovel.fromV3ConfigFile(filterFiles.first);
      //novel
      novel.isAdult = config.isAdult;
      novel.isCompleted = config.isCompleted;
      // fields
      titleController.text = config.title;
      authorController.text = config.author;
      translatorController.text = config.translator;
      mcController.text = config.mc;
      // coverUrlController.text = config.coverUrl;
      descController.text = config.desc;

      setState(() {});

      if (!mounted) return;
      showTSnackBar(context, 'config Added');
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      enable: true,
      onDragDone: onDragDone,
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Novel')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                // cover
                Row(
                  spacing: 8,
                  children: [
                    Column(
                      children: [
                        TCoverChooser(
                          coverPath: novel.coverPath,
                          onChanged: () {
                            coverUrlController.text =
                                ServerFileServices.getImageUrl(
                                  novel.coverPath.getName(),
                                );
                          },
                        ),
                        Text('Local Cover'),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: TImageUrl(url: coverUrlController.text),
                        ),
                        Text('Online Cover'),
                      ],
                    ),
                  ],
                ),
                // fields
                TTextField(
                  label: Text('အမည်'),
                  controller: titleController,
                  isSelectedAll: true,
                  maxLines: 1,
                ),
                TTextField(
                  label: Text('Cover Url'),
                  controller: coverUrlController,
                  maxLines: 1,
                  onChanged: (value) {
                    setState(() {});
                  },
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
                  title: Text('Tags'),
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
                  title: Text('Page Urls'),
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
      ),
    );
  }
}
