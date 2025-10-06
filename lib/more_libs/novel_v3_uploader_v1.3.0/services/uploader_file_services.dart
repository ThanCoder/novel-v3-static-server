import '../novel_v3_uploader.dart';

class UploaderFileServices {
  static final Map<String, DatabaseInterface<UploaderFile>> _dbCache = {};

  static DatabaseInterface<UploaderFile> get getLocalDatabase {
    if (_dbCache['local'] == null) {
      _dbCache['local'] = DatabaseFactory.create<UploaderFile>(
        DatabaseTypes.local,
      );
    }
    return _dbCache['local']!;
  }

  static DatabaseInterface<UploaderFile> get getApiDatabase {
    if (_dbCache['online'] == null) {
      _dbCache['online'] = DatabaseFactory.create<UploaderFile>(
        DatabaseTypes.api,
      );
    }
    return _dbCache['online']!;
  }

  static Future<List<UploaderFile>> getLocalList({
    required String novelId,
  }) async {
    final list = await getLocalDatabase.getAll(query: {'id': novelId});
    return list;
  }

  static Future<List<UploaderFile>> getApiList({
    required String novelId,
  }) async {
    final list = await getApiDatabase.getAll(query: {'id': novelId});
    return list;
  }
}
