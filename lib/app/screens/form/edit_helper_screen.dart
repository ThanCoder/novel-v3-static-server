import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.2.0/models/helper_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.2.0/services/helper_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/dialogs/t_rename_dialog.dart';
import 'package:t_widgets/widgets/index.dart';

class EditHelperScreen extends StatefulWidget {
  HelperFile helper;
  EditHelperScreen({super.key, required this.helper});

  @override
  State<EditHelperScreen> createState() => _EditHelperScreenState();
}

class _EditHelperScreenState extends State<EditHelperScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  late HelperFile helper;

  @override
  void initState() {
    helper = widget.helper;
    super.initState();
    init();
  }

  void init() {
    titleController.text = helper.title;
    descController.text = helper.desc;
  }

  void _onSaved() {
    helper.title = titleController.text;
    helper.desc = descController.text;

    context.read<HelperServices>().update(helper);

    Navigator.pop(context);
  }

  void _addCoverUrl() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TRenameDialog(
        text: '',
        autofocus: true,
        onCheckIsError: (text) {
          if (text.isEmpty) {
            return 'url is required';
          }
          return null;
        },
        onSubmit: (text) {
          helper.imagesUrl.add(text);
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Helper')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  TTextField(
                    label: Text('Title'),
                    maxLines: 1,
                    isSelectedAll: true,
                    controller: titleController,
                  ),
                  TTextField(
                    label: Text('Desc'),
                    maxLines: null,
                    isSelectedAll: true,
                    controller: descController,
                  ),
                  Text('Images'),
                ],
              ),
            ),
            // list
            SliverList.separated(
              separatorBuilder: (context, index) => Row(
                children: [
                  Text('Image Index -> $index', style: TextStyle(fontSize: 20)),
                  const Divider(),
                ],
              ),
              itemCount: helper.imagesUrl.length,
              itemBuilder: (context, index) {
                final url = helper.imagesUrl[index];
                return TImageUrl(url: url, width: double.infinity);
              },
            ),
            // add
            SliverToBoxAdapter(
              child: IconButton(
                color: Colors.blue,
                onPressed: _addCoverUrl,
                icon: Icon(Icons.add_circle_outline_outlined),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaved,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
