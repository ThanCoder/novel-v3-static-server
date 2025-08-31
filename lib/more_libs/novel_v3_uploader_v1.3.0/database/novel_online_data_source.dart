import '../core/sources/online_data_source.dart';

import '../models/novel.dart';

class NovelOnlineDataSource extends OnlineDataSource<Novel> {
  NovelOnlineDataSource({required super.fileSource});

  @override
  Future<void> add(Novel value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Novel value) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Novel fromMap(Map<String, dynamic> map) {
    return Novel.fromMap(map);
  }

  @override
  Future<void> update(Novel value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
