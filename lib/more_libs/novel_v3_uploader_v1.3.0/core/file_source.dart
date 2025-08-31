// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

abstract class FileSource {
  final String root;
  FileSource({required this.root});
  Future<String> getServerPath() async {
    return root;
  }

  Future<String> getMainDBPath() async {
    return '$root/main.db.json';
  }

  Future<String> getContentDBPath(String? name) async {
    final path = createDir('$root/content_db');
    if (name != null && name.isNotEmpty) {
      return '$path/$name';
    }
    return path;
  }

  Future<String> getFilePath(String? name) async {
    final path = createDir('$root/files');
    if (name != null && name.isNotEmpty) {
      return '$path/$name';
    }
    return path;
  }

  Future<String> getImagePath(String? name) async {
    final path = createDir('$root/images');
    if (name != null && name.isNotEmpty) {
      return '$path/$name';
    }
    return path;
  }

  Future<String> createDir(String path) async {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
