import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file.dart';
import 'package:than_pkg/extensions/datetime_extension.dart';
import 'package:than_pkg/than_pkg.dart';

class UploaderFileItem extends StatelessWidget {
  UploaderFile file;
  void Function(UploaderFile file) onClicked;
  void Function(UploaderFile file)? onRightClicked;
  UploaderFileItem({
    super.key,
    required this.file,
    required this.onClicked,
    this.onRightClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClicked(file),
      onSecondaryTap: () {
        if (onRightClicked == null) return;
        onRightClicked!(file);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                // SizedBox(
                //   width: 180,
                //   height: 220,
                //   child: TImageFile(path: file.),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(file.name),
                      Text('Type: ${file.type.name.toCaptalize()}'),
                      Text('Size: ${file.fileSize}'),
                      Text('ရက်စွဲ: ${file.date.toParseTime()}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
