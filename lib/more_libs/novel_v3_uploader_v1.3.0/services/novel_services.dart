import '../novel_v3_uploader.dart';

class NovelServices {
  static final Map<String, DataSource<Novel>> _dbCache = {};

  static DataSource<Novel> getLocalDatabase() {
    if (_dbCache['local-novel'] == null) {
      _dbCache['local-novel'] = DataSourceFactory.getLocal<Novel>();
    }
    return _dbCache['local-novel']!;
  }

  static DataSource<Novel> getOnlineDatabase() {
    if (_dbCache['online-novel'] == null) {
      _dbCache['online-novel'] = DataSourceFactory.getLocal<Novel>();
    }
    return _dbCache['online-novel']!;
  }

  static Future<List<Novel>> getLocalList() async {
    final database = getLocalDatabase();
    return await database.getAll();
  }

  static Future<List<Novel>> getOnlineList() async {
    final database = getOnlineDatabase();
    return await database.getAll();
  }
}
