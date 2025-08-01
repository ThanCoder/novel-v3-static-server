// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file_types.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/services/server_file_services.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:uuid/uuid.dart';

class UploaderFile {
  String id;
  String novelId;
  String title;
  UploaderFileTypes type;
  String content;
  DateTime date;
  UploaderFile({
    required this.id,
    required this.novelId,
    required this.title,
    required this.content,
    required this.date,
    required this.type,
  });

  factory UploaderFile.createFromPath(String path, {required String novelId}) {
    final file = UploaderFile.create(
      novelId: novelId,
      title: path.getName(),
      type: UploaderFileTypes.getTypeFromPath(path),
    );
    return file;
  }

  factory UploaderFile.create({
    required String novelId,
    String title = 'Untitled',
    UploaderFileTypes type = UploaderFileTypes.v3Data,
  }) {
    final id = Uuid().v4();
    return UploaderFile(
      id: id,
      novelId: novelId,
      title: title,
      content: '${ServerFileServices.getFilesPath(absPath: true)}/$id',
      date: DateTime.now(),
      type: type,
    );
  }

  factory UploaderFile.fromMap(Map<String, dynamic> map) {
    final dateFromMillisecondsSinceEpoch = MapServices.get<int>(map, [
      'date',
    ], defaultValue: 0);
    final typeStr = MapServices.get(map, ['type'], defaultValue: '');
    final type = UploaderFileTypes.getTypeString(typeStr);

    return UploaderFile(
      id: MapServices.get(map, ['id'], defaultValue: ''),
      title: MapServices.get(map, ['title'], defaultValue: 'Untitled'),
      novelId: MapServices.get(map, ['novelId'], defaultValue: ''),
      content: MapServices.get(map, ['content'], defaultValue: ''),
      type: type,
      date: DateTime.fromMillisecondsSinceEpoch(dateFromMillisecondsSinceEpoch),
    );
  }

  Map<String, dynamic> get toMap => {
    'id': id,
    'novelId': novelId,
    'title': title,
    'content': content,
    'type': type.name,
    'date': date.millisecondsSinceEpoch,
  };

  String get getLocalSizeLable {
    final file = File(content);
    if(!file.existsSync()) return '';
    return file.statSync().size.toDouble().toFileSizeLabel();
  }
}
