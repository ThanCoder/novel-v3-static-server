import '../file_source.dart';
import '../sources/local_file_source.dart';
import '../sources/online_file_source.dart';

enum FileFactoryTypes { local, online }

class FileFactory {
  static FileSource create(
    FileFactoryTypes type, {
    required String rootPath,
    required String rootUrl,
  }) {
    switch (type) {
      case FileFactoryTypes.local:
        if (rootPath.isEmpty) throw ArgumentError('Local Path required!');
        return LocalFileSource(root: rootPath);
      case FileFactoryTypes.online:
        if (rootUrl.isEmpty) throw ArgumentError('Online Url required!');
        return OnlineFileSource(root: rootUrl);
    }
  }
}
