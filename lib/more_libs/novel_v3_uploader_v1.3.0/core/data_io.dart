import 'dart:io';

abstract class DataIO {
  Future<void> write(String path, String data);
  Future<String> read(String path);
}

class FileWriterIO implements DataIO {
  static final FileWriterIO instance = FileWriterIO._();
  FileWriterIO._();
  factory FileWriterIO() => instance;

  @override
  Future<void> write(String path, String json) async {
    final file = File(path);
    await file.writeAsString(json);
  }

  @override
  Future<String> read(String path) async {
    final file = File(path);
    if (!file.existsSync()) return '';
    return await file.readAsString();
  }
}
