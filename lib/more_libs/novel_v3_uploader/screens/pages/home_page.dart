import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_novel.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:than_pkg/than_pkg.dart';

class HomePage extends StatelessWidget {
  UploaderNovel novel;
  HomePage({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 180,
                      height: 220,
                      child: TCacheImage(
                        url: novel.coverUrl,
                        // cachePath: PathUtil.getCachePath(),
                      ),
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 3,
                    children: [
                      Text(novel.title, maxLines: null),
                      Text('Author: ${novel.author}'),
                      Text('ဘာသာပြန်: ${novel.translator}'),
                      Text('MC: ${novel.mc}'),

                      TChip(
                        title: Text(
                          novel.isCompleted ? 'isCompleted' : 'OnGoing',
                          style: TextStyle(
                            color: novel.isCompleted
                                ? Colors.teal
                                : Colors.grey,
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
            TTagsWrapView(values: novel.getTags),

            SelectableText(novel.desc, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
