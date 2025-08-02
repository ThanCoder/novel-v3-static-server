import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/online_novel_grid_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/components/see_all_view.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';

class OnlineNovelSeeAllView extends StatelessWidget {
  String title;
  List<UploaderNovel> list;
  Color? titleColor;
  void Function(String title, List<UploaderNovel> list) onSeeAllClicked;
  void Function(UploaderNovel novel) onClicked;
  OnlineNovelSeeAllView({
    super.key,
    required this.title,
    required this.list,
    required this.onSeeAllClicked,
    required this.onClicked,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return SeeAllView<UploaderNovel>(
      title: title,
      titleColor: titleColor,
      list: list,
      onSeeAllClicked: onSeeAllClicked,
      itemBuilder: (context, index) =>
          OnlineNovelGridItem(novel: list[index], onClicked: onClicked),
    );
  }
}
