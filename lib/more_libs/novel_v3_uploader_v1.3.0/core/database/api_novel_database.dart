import '../../novel_v3_uploader.dart';

class ApiNovelDatabase extends ApiDatabaseInterface<Novel> {
  ApiNovelDatabase()
    : super(
        root: '${NovelV3Uploader.instance.getApiServerUrl()}/main.db.json',
        storage: Storage(
          root: '${NovelV3Uploader.instance.getApiServerUrl()}/images',
        ),
      );

  @override
  Novel fromMap(Map<String, dynamic> map) {
    return Novel.fromMap(map);
  }

  @override
  Future<void> add(Novel value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, Novel value) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(Novel value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
