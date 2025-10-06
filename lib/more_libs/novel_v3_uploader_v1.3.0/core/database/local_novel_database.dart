import '../../novel_v3_uploader.dart';

class LocalNovelDatabase extends LocalDatabaseInterface<Novel> {
  LocalNovelDatabase()
    : super(
        root: '${NovelV3Uploader.instance.getLocalServerPath()}/main.db.json',
        storage: Storage(
          root: '${NovelV3Uploader.instance.getLocalServerPath()}/images',
        ),
      );
  @override
  Novel fromMap(Map<String, dynamic> map) {
    return Novel.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Novel value) {
    return value.toMap();
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
}
