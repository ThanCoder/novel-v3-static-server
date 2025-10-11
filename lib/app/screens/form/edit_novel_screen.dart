import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/novel_v3_uploader.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/services/server_file_services.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';

class EditNovelScreen extends StatefulWidget {
  Novel novel;
  void Function(Novel updatedNovel) onUpdated;
  EditNovelScreen({super.key, required this.novel, required this.onUpdated});

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
  late Novel novel;
  String? errorTitle;
  List<String> alreadyTitleList = [];
  List<Novel> novelList = [];

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
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
  }

  void init() async {
    novelList = await NovelServices.getLocalDatabase.getAll();
    alreadyTitleList = novelList
        .where((e) => e.title != novel.title)
        .map((e) => e.title)
        .toList();
    if (!mounted) return;

    _checkAlreadyTitle();
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
                  errorText: errorTitle,
                  maxLines: 1,
                  autofocus: true,
                  onChanged: (value) {
                    _checkAlreadyTitle();
                  },
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
                  isSelectedAll: true,
                ),
                TTextField(
                  label: Text('ဘာသာပြန်သူ'),
                  controller: translatorController,
                  maxLines: 1,
                  isSelectedAll: true,
                ),
                TTextField(
                  label: Text('အထိက ဇောတ်ကောင်'),
                  controller: mcController,
                  maxLines: 1,
                  isSelectedAll: true,
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
                  onAddButtonClicked: () {
                    showTReanmeDialog(
                      context,
                      barrierDismissible: false,
                      autofocus: true,
                      submitText: 'Add',
                      cancelText: 'Close',
                      text: '',
                      onCheckIsError: (text) {
                        if (!text.startsWith('http')) {
                          return 'http url is required!';
                        }
                        return null;
                      },
                      onSubmit: (text) {
                        setState(() {
                          final values = novel.getPageUrls;
                          values.insert(0, text);
                          novel.setPageUrl(values);
                        });
                      },
                    );
                  },
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
        floatingActionButton: errorTitle != null
            ? null
            : FloatingActionButton(
                onPressed: _onSaved,
                child: Icon(Icons.save_as_rounded),
              ),
      ),
    );
  }

  List<String> get _getAllTags {
    List<String> allTags = [];
    for (var novel in novelList) {
      allTags.addAll(novel.getTags);
    }
    return allTags.toSet().toList();
  }

  void _checkAlreadyTitle() {
    if (alreadyTitleList.contains(titleController.text)) {
      errorTitle = 'title ရှိနေပြီးသားဖြစ်နေပါတယ်';
    } else {
      errorTitle = null;
    }
    setState(() {});
  }

  void onDragDone(DropDoneDetails details) async {
    try {
      final files = details.files.map((e) => e.path).toList();
      // cover files
      final coverFiles = ServerFileServices.getAccessableCoverFiles(files);
      if (coverFiles.isNotEmpty) {
        final file = File(coverFiles.first);
        final oldFile = File(novel.coverPath);
        if (oldFile.existsSync()) {
          oldFile.deleteSync();
        }
        file.renameSync(novel.coverPath);
        coverUrlController.text = ServerFileServices.getImageUrl(
          novel.coverPath.getName(),
        );
        setState(() {});
        return;
      }
      // config
      final configFiles = ServerFileServices.getAccessableConfigFiles(files);
      if (configFiles.isEmpty) return;
      // move file
      final config = Novel.fromV3ConfigFile(configFiles.first);
      //novel
      novel.isAdult = config.isAdult;
      novel.isCompleted = config.isCompleted;
      novel.tags = config.tags;
      novel.pageUrls = config.pageUrls;
      // fields
      titleController.text = config.title;
      authorController.text = config.author;
      translatorController.text = config.translator;
      mcController.text = config.mc;
      // coverUrlController.text = config.coverUrl;
      descController.text = config.desc;
      // title ရှိနေပြီးသားလား စစ်ဆေးမယ်
      if (alreadyTitleList.contains(titleController.text)) {
        errorTitle = 'title ရှိနေပြီးသားဖြစ်နေပါတယ်';
      } else {
        errorTitle = null;
      }
      // error မရှိနေရင် cover file ကို move မယ်
      final coverFile = File(config.coverPath);
      if (coverFile.existsSync()) {
        final oldFile = File(novel.coverPath);
        if (oldFile.existsSync()) {
          oldFile.deleteSync();
        }
        // coverFile.renameSync(novel.coverPath);
        coverFile.copySync(novel.coverPath);

        coverUrlController.text = ServerFileServices.getImageUrl(
          novel.coverPath.getName(),
        );
      }
      setState(() {});

      if (!mounted) return;
      showTSnackBar(context, 'config Added');
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  void _onSaved() async {
    novel.title = titleController.text.trim();
    novel.author = authorController.text.trim();
    novel.translator = translatorController.text.trim();
    novel.mc = mcController.text.trim();
    novel.desc = descController.text;
    novel.newDate();
    Navigator.pop(context);

    // on update
    widget.onUpdated(novel);
  }
}
