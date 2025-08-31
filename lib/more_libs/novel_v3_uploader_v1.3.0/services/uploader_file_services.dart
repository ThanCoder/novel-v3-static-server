import '../novel_v3_uploader.dart';

class UploaderFileServices {
  static final Map<String, DataSource<UploaderFile>> _dbCache = {};

  static DataSource<UploaderFile> getLocalDatabase() {
    if (_dbCache['local'] == null) {
      _dbCache['local'] = DataSourceFactory.getLocal<UploaderFile>();
    }
    return _dbCache['local']!;
  }

  static DataSource<UploaderFile> getOnlineDatabase() {
    if (_dbCache['online'] == null) {
      _dbCache['online'] = DataSourceFactory.getOnline<UploaderFile>();
    }
    return _dbCache['online']!;
  }

  static Future<List<UploaderFile>> getLocalList({
    required String novelId,
  }) async {
    final list = await getLocalDatabase().getAll(id: novelId);
    return list;
  }

  static Future<List<UploaderFile>> getOnlineList({
    required String novelId,
  }) async {
    final list = await getOnlineDatabase().getAll(id: novelId);
    return list;
  }
}
