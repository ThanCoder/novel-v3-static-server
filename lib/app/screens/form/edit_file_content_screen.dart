import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/uploader_file_chooser.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file.dart';
import 'package:t_widgets/t_widgets.dart';

class EditFileContentScreen extends StatefulWidget {
  UploaderFile file;
  void Function(UploaderFile file) onUpdated;
  EditFileContentScreen({
    super.key,
    required this.file,
    required this.onUpdated,
  });

  @override
  State<EditFileContentScreen> createState() => _EditFileContentScreenState();
}

class _EditFileContentScreenState extends State<EditFileContentScreen> {
  final nameConstroller = TextEditingController();
  final fileUrlConstroller = TextEditingController();
  final fileSizeConstroller = TextEditingController();
  late UploaderFile file;

  @override
  void initState() {
    file = widget.file;
    nameConstroller.text = file.name;
    fileUrlConstroller.text = file.fileUrl;
    fileSizeConstroller.text = file.fileSize;
    // nameConstroller.text = file.;
    super.initState();
  }

  void _onSaved() async {
    try {
      file.name = nameConstroller.text;
      file.fileUrl = fileUrlConstroller.text;
      file.fileSize = fileSizeConstroller.text;

      if (!mounted) return;

      Navigator.pop(context);
      widget.onUpdated(file);
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Content File')),
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
              ),
              // types
              UploaderFileChooser(
                value: file.type,
                onChanged: (value) {
                  setState(() {
                    file.type = value;
                  });
                },
              ),
              // direct link
              SwitchListTile.adaptive(
                title: Text('Is Direct Download Link'),
                value: file.isDirectLink,
                onChanged: (value) {
                  setState(() {
                    file.isDirectLink = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  _onSaved,
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
