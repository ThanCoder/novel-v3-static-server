import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/uploader_file_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/server_file_services.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/uploader_file_services.dart';
import 'package:provider/provider.dart';
import 'package:t_widgets/t_widgets.dart';

class EditNovelContentScreen extends StatefulWidget {
  UploaderNovel novel;
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

  void init() async {
    context.read<UploaderFileServices>().initList();
  }

  void onDragDone(DropDoneDetails details) async {
    try {
      final files = details.files.map((e) => e.path).toList();
      final filterFiles = ServerFileServices.getAccessableFiles(files);
      if (filterFiles.isEmpty) return;

      final uploadFile = UploaderFile.createFromPath(
        filterFiles.first,
        novelId: widget.novel.id,
      );
      await context.read<UploaderFileServices>().add(
        filterFiles.first,
        uploadFile,
      );

      if (!mounted) return;
      showTSnackBar(context, '${uploadFile.title} Added');
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UploaderFileServices>();
    final isLoading = provider.isLoading;
    final list = provider.getList;

    return DropTarget(
      enable: true,
      onDragDone: onDragDone,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.novel.title)),
        body: isLoading ? Center(child: TLoaderRandom()) : CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: list.length,
              itemBuilder: (context, index) =>
                  UploaderFileItem(file: list[index], onClicked: (file) {}),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
