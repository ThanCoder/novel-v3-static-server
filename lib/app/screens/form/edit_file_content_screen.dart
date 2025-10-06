import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/uploader_file_chooser.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/uploader_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/services/uploader_file_services.dart';
import 'package:t_widgets/t_widgets.dart';

class EditFileContentScreen extends StatefulWidget {
  final UploaderFile file;
  const EditFileContentScreen({super.key, required this.file});

  @override
  State<EditFileContentScreen> createState() => _EditFileContentScreenState();
}

class _EditFileContentScreenState extends State<EditFileContentScreen> {
  final nameConstroller = TextEditingController();
  final fileUrlConstroller = TextEditingController();
  final fileSizeConstroller = TextEditingController();
  final descriptionConstroller = TextEditingController();
  late UploaderFile file;

  @override
  void initState() {
    file = widget.file;
    nameConstroller.text = file.name;
    fileUrlConstroller.text = file.fileUrl;
    fileSizeConstroller.text = file.fileSize;
    descriptionConstroller.text = file.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 15,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TTextField(
                label: Text('Name'),
                controller: nameConstroller,
                maxLines: 1,
                isSelectedAll: true,
                autofocus: true,
                onSubmitted: (value) => _onSaved(),
              ),
              TTextField(
                label: Text('File Url'),
                controller: fileUrlConstroller,
                maxLines: 1,
                isSelectedAll: true,
              ),
              TTextField(
                label: Text('File Size'),
                controller: fileSizeConstroller,
                maxLines: 1,
                // isSelectedAll: true,
                onSubmitted: (value) => _onSaved(),
              ),
              TTextField(
                label: Text('Description'),
                controller: descriptionConstroller,
                maxLines: null,
              ),
              // direct link
              SwitchListTile.adaptive(
                title: Text('Is Direct Download Link'),
                value: file.isDirectLink,
                onChanged: (value) {
                  file = file.copyWith(isDirectLink: value);
                  setState(() {});
                },
              ),
              // types
              UploaderFileChooser(
                value: file.type,
                onChanged: (value) {
                  file = file.copyWith(type: value);
                  setState(() {});
                },
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

  AppBar _getAppbar() {
    return AppBar(
      title: Text('Edit Content File'),
      actions: [
        IconButton(
          onPressed: _onDeleteConfirm,
          color: Colors.red,
          icon: Icon(Icons.delete_forever),
        ),
      ],
    );
  }

  void _onDeleteConfirm() {
    showTConfirmDialog(
      context,
      contentText: 'ဖျက်ချင်တာ သေချာပြီလား?',
      submitText: 'Delete Forever!',
      onSubmit: () async {
        try {
          await UploaderFileServices.getLocalDatabase(
            widget.file.novelId,
          ).delete(file.id);

          if (!mounted) return;
          Navigator.pop(context);
        } catch (e) {
          if (!mounted) return;
          showTMessageDialogError(context, e.toString());
        }
      },
    );
  }

  void _onSaved() async {
    try {
      file = file.copyWith(
        name: nameConstroller.text,
        fileUrl: fileUrlConstroller.text,
        fileSize: fileSizeConstroller.text,
        description: descriptionConstroller.text,
      );

      await UploaderFileServices.getLocalDatabase(
        widget.file.novelId,
      ).update(file.id, file);

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }
}
