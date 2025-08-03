import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.2.0/models/uploader_file_types.dart';
import 'package:than_pkg/than_pkg.dart';

class UploaderFileChooser extends StatelessWidget {
  UploaderFileTypes value;
  void Function(UploaderFileTypes value) onChanged;
  UploaderFileChooser({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text('Uploader File Types'),
        DropdownButton<UploaderFileTypes>(
          padding: EdgeInsets.all(6),
          borderRadius: BorderRadius.circular(4),
          value: value,
          items: UploaderFileTypes.values
              .map(
                (e) => DropdownMenuItem<UploaderFileTypes>(
                  value: e,
                  child: Text(e.name.toCaptalize()),
                ),
              )
              .toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ],
    );
  }
}
