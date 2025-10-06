import '../../novel_v3_uploader.dart';

class DatabaseFactory {
  static DatabaseInterface<T> create<T>(DatabaseTypes type) {
    if (T == Novel) {
      switch (type) {
        case DatabaseTypes.local:
          return LocalNovelDatabase() as DatabaseInterface<T>;
        case DatabaseTypes.api:
          return ApiNovelDatabase() as DatabaseInterface<T>;
      }
    }
    if (T == UploaderFile) {
      switch (type) {
        case DatabaseTypes.local:
          return LocalUploaderFileDatabase() as DatabaseInterface<T>;
        case DatabaseTypes.api:
          return ApiUploaderFileDatabase() as DatabaseInterface<T>;
      }
    }

    throw UnsupportedError('T: `$T` Not Supported Database!');
  }
}

enum DatabaseTypes { local, api }
