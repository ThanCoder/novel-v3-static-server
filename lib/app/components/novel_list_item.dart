import 'package:flutter/material.dart';
import 'package:t_widgets/widgets/index.dart';
import 'package:than_pkg/extensions/datetime_extension.dart';

import '../../more_libs/novel_v3_uploader_v1.3.0/novel_v3_uploader.dart';
import '../../more_libs/novel_v3_uploader_v1.3.0/ui/components/status_text.dart';
import '../../more_libs/novel_v3_uploader_v1.3.0/ui/components/tag_wrap_view.dart';

class NovelListItem extends StatelessWidget {
  Novel novel;
  void Function(Novel novel) onClicked;
  void Function(Novel novel)? onRightClicked;
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
            child: Wrap(
              runSpacing: 8,
              spacing: 8,
              children: [
                SizedBox(
                  width: 140,
                  height: 160,
                  child: TImageFile(path: novel.coverPath),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 3,
                  children: [
                    Text(
                      novel.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'Author: ${novel.author}',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      'ဘာသာပြန်: ${novel.translator}',
                      style: TextStyle(fontSize: 13),
                    ),
                    Text('MC: ${novel.mc}', style: TextStyle(fontSize: 13)),
                    // TTagsWrapView(values: novel.getTags),
                    TagWrapView(list: novel.getTags),
                    Wrap(
                      spacing: 5,
                      children: [
                        StatusText(
                          bgColor: novel.isCompleted
                              ? StatusText.completedColor
                              : StatusText.onGoingColor,
                          text: novel.isCompleted ? 'Completed' : 'OnGoing',
                        ),
                        novel.isAdult
                            ? StatusText(
                                text: 'Adult',
                                bgColor: StatusText.adultColor,
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
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
