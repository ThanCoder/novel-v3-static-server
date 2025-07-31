// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/uploader_file_types.dart';
import 'package:uuid/uuid.dart';

class UploaderFile {
  String id;
  String novelId;
  String title;
  UploaderFileTypes types;
  String content;
  DateTime date;
  UploaderFile({
    required this.id,
    required this.novelId,
    required this.title,
    required this.content,
    required this.date,
    required this.types,
  });

  factory UploaderFile.create({
    required String novelId,
    String title = 'Untitled',
    String content = '',
    UploaderFileTypes types = UploaderFileTypes.v3Data,
  }) {
    return UploaderFile(
      id: Uuid().v4(),
      novelId: novelId,
      title: title,
      content: content,
      date: DateTime.now(),
      types: types,
    );
  }
}
