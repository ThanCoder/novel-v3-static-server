import '../novel_v3_uploader.dart';

class DataSourceFactory {
  static DataSource<T> getLocal<T>() {
    if (T == Novel) {
      final source = NovelLocalDataSource(
        FileWriterIO.instance,
        fileSource: LocalFileSource(
          root: NovelV3Uploader.instance.getCustomServerPath(),
        ),
      );
      return source as DataSource<T>;
    }
    if (T == UploaderFile) {
      final source = UploaderFileLocalDataSource(
        FileWriterIO.instance,
        fileSource: LocalFileSource(
          root: NovelV3Uploader.instance.getCustomServerPath(),
        ),
      );
      return source as DataSource<T>;
    }
    throw UnsupportedError('not found data source: $T');
  }

  static DataSource<T> getOnline<T>() {
    if (T == Novel) {
      final source = NovelOnlineDataSource(
        fileSource: OnlineFileSource(
          root: NovelV3Uploader.instance.getRootServerUrl(),
        ),
      );
      return source as DataSource<T>;
    }
    if (T == UploaderFile) {
      final source = UploaderFileOnlineDataSource(
        fileSource: OnlineFileSource(
          root: NovelV3Uploader.instance.getRootServerUrl(),
        ),
      );
      return source as DataSource<T>;
    }
    throw UnsupportedError('not found data source: $T');
  }
}
