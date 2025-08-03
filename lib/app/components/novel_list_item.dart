import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/uploader_novel.dart';
import 'package:t_widgets/views/t_tags_wrap_view.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:than_pkg/extensions/datetime_extension.dart';

class NovelListItem extends StatelessWidget {
  UploaderNovel novel;
  void Function(UploaderNovel novel) onClicked;
  void Function(UploaderNovel novel)? onRightClicked;
  NovelListItem({
    super.key,
    required this.novel,
    required this.onClicked,
    this.onRightClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(novel),
      onSecondaryTap: () {
        if (onRightClicked == null) return;
        onRightClicked!(novel);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                SizedBox(
                  width: 180,
                  height: 220,
                  child: TImageFile(path: novel.coverPath),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(novel.title),
                    Text('Author: ${novel.author}'),
                    Text('ဘာသာပြန်: ${novel.translator}'),
                    Text('MC: ${novel.mc}'),
                    // Text('Tags: ${novel.tags}'),
                    TTagsWrapView(values: novel.getTags),
                    // Text('isAdult: ${novel.isAdult.toString()}'),
                    // Text('isCompleted: ${novel.isCompleted.toString()}'),
                    TChip(
                      title: Text(
                        novel.isCompleted ? 'isCompleted' : 'OnGoing',
                        style: TextStyle(
                          color: novel.isCompleted ? Colors.teal : Colors.grey,
                        ),
                      ),
                    ),
                    novel.isAdult
                        ? TChip(
                            title: Text(
                              'isAdult',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        : SizedBox.shrink(),
                    Text('ရက်စွဲ: ${novel.date.toParseTime()}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
