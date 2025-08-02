import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/novel_grid_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/see_all_view.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';

class NovelSeeAllView extends StatelessWidget {
  String title;
  List<UploaderNovel> list;
  Color? titleColor;
  int? showLines;
  void Function(String title, List<UploaderNovel> list) onSeeAllClicked;
  void Function(UploaderNovel novel) onClicked;
  void Function(UploaderNovel novel)? onRightClicked;
  NovelSeeAllView({
    super.key,
    required this.title,
    required this.list,
    required this.onSeeAllClicked,
    required this.onClicked,
    this.onRightClicked,
    this.titleColor,
    this.showLines,
  });

  @override
  Widget build(BuildContext context) {
    return SeeAllView<UploaderNovel>(
      title: title,
      titleColor: titleColor,
      showLines: showLines,
      list: list,
      onSeeAllClicked: onSeeAllClicked,
      itemBuilder: (context, index) => NovelGridItem(
        novel: list[index],
        onClicked: onClicked,
        onRightClicked: onRightClicked,
      ),
    );
  }
}
