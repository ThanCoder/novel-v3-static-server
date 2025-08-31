import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';

import '../../novel_v3_uploader.dart';

class UploaderFilePage extends StatefulWidget {
  Novel novel;
  UploaderFilePage({super.key, required this.novel});

  @override
  State<UploaderFilePage> createState() => _UploaderFilePageState();
}

class _UploaderFilePageState extends State<UploaderFilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((e) => init());
    super.initState();
  }

  List<UploaderFile> list = [];
  bool isLoading = false;

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    list = await UploaderFileServices.getOnlineList(novelId: widget.novel.id);
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: TLoaderRandom());
    }
    return RefreshIndicator.adaptive(onRefresh: init, child: _getListWidget());
  }

  Widget _getListWidget() {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List is Empty'),
            IconButton(
              color: Colors.blue,
              onPressed: init,
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) =>
          OnlineFileListItem(file: list[index], onClicked: _download),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: list.length,
    );
  }

  void _download(UploaderFile file) async {
    if (NovelV3Uploader.instance.onDownloadUploaderFile != null) {
      NovelV3Uploader.instance.onDownloadUploaderFile?.call(context, file);
      return;
    }
    try {
      if (file.isDirectLink) {
        // direct download
      }
      await ThanPkg.platform.launch(file.fileUrl);
    } catch (e) {
      if (!mounted) return;
      showTMessageDialogError(context, e.toString());
    }
  }
}
