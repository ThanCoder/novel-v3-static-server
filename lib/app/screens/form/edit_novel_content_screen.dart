import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/uploader_file_item.dart';
import 'package:novel_v3_static_server/app/routes_helper.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/uploader_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/services/server_file_services.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';

class EditNovelContentScreen extends StatefulWidget {
  Novel novel;
  EditNovelContentScreen({super.key, required this.novel});

  @override
  State<EditNovelContentScreen> createState() => _EditNovelContentScreenState();
}

class _EditNovelContentScreenState extends State<EditNovelContentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
    super.initState();
  }

  bool isLoading = false;
  List<UploaderFile> uploaderList = [];

  void init() async {
    // context.read<UploaderFileServices>().initList(novelId: widget.novel.id);
  }

  void onDragDone(DropDoneDetails details) async {
    try {
      final files = details.files.map((e) => e.path).toList();
      final filterFiles = ServerFileServices.getAccessableFiles(files);
      if (filterFiles.isEmpty) return;
      // move file

      // create db file
      final uploadFile = UploaderFile.createFromPath(
        filterFiles.first,
        novelId: widget.novel.id,
        fileName: filterFiles.first.getName(),
      );
      // await context.read<UploaderFileServices>().add(uploadFile);

      if (!mounted) return;
      showTSnackBar(context, '${uploadFile.name} Added');
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  void _deleteConfirm(UploaderFile file) {
    showDialog(
      context: context,
      builder: (context) => TConfirmDialog(
        contentText: 'ဖျက်ချင်တာ သေချာပြီလား?',
        onSubmit: () {
          // context.read<UploaderFileServices>().delete(file);
        },
      ),
    );
  }

  void _onRightClicked(UploaderFile file) {
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
                  file.name,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),

              ListTile(
                iconColor: Colors.red,
                leading: Icon(Icons.delete_forever),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _deleteConfirm(file);
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.novel.title)),
      body: isLoading
          ? Center(child: TLoaderRandom())
          : DropTarget(
              enable: true,
              onDragDone: onDragDone,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: uploaderList.length,
                    itemBuilder: (context, index) => UploaderFileItem(
                      file: uploaderList[index],
                      onClicked: (file) {
                        goEditContentFileScreen(
                          context,
                          file,
                          onUpdated: (file) async {
                            try {
                              // await context.read<UploaderFileServices>().update(
                              //   file,
                              // );
                              if (!context.mounted) return;
                              showTSnackBar(context, '${file.name} Updated');
                            } catch (e) {
                              if (!context.mounted) return;
                              showTMessageDialogError(context, e.toString());
                            }
                          },
                        );
                      },
                      onRightClicked: _onRightClicked,
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goEditContentFileScreen(
            context,
            UploaderFile.createEmpty(novelId: widget.novel.id),
            onUpdated: (file) async {
              try {
                // await context.read<UploaderFileServices>().add(file);
                // if (!context.mounted) return;
                // showTSnackBar(context, '${file.name} Added');
              } catch (e) {
                if (!context.mounted) return;
                showTMessageDialogError(context, e.toString());
              }
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
