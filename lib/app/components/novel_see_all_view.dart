import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/app/components/novel_grid_item.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/core/models/novel.dart';
import 'package:t_widgets/t_widgets.dart';

class NovelSeeAllView extends StatelessWidget {
  String title;
  List<Novel> list;
  Color? titleColor;
  int? showLines;
  void Function(String title, List<Novel> list)? onSeeAllClicked;
  void Function(Novel novel) onClicked;
  void Function(Novel novel)? onRightClicked;
  NovelSeeAllView({
    super.key,
    required this.title,
    required this.list,
    this.onSeeAllClicked,
    required this.onClicked,
    this.onRightClicked,
    this.titleColor,
    this.showLines,
  });

  @override
  Widget build(BuildContext context) {
    return TSeeAllView<Novel>(
      title: title,
      titleColor: titleColor,
      showLines: showLines,
      list: list,
      onSeeAllClicked: (title, list) {
        
      },
      gridItemBuilder: (context, item) => SizedBox(
        width: 140,
        height: 180,
        child: NovelGridItem(
          novel: item,
          onClicked: onClicked,
          onRightClicked: onRightClicked,
        ),
      ),
    );
  }
}
