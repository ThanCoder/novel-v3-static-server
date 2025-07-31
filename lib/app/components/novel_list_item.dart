import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:than_pkg/extensions/datetime_extension.dart';

class NovelListItem extends StatelessWidget {
  UploaderNovel novel;
  void Function(UploaderNovel novel) onClicked;
  NovelListItem({super.key, required this.novel, required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(novel),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                SizedBox(
                  width: 180,
                  height: 220,
                  child: TImageUrl(url: novel.coverUrl),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(novel.title),
                    Text('Author: ${novel.author}'),
                    Text('ဘာသာပြန်: ${novel.translator}'),
                    Text('အထိက ဇောတ်ကောင်${novel.mc}'),
                    Text('Tags: ${novel.tags}'),
                    Text('isAdult: ${novel.isAdult.toString()}'),
                    Text('isCompleted: ${novel.isCompleted.toString()}'),
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
