import 'dart:io';

import 'package:novel_v3_static_server/app/models/novel.dart';
import 'package:novel_v3_static_server/core/data/database/local/json/data_io.dart';
import 'package:novel_v3_static_server/core/data/database/local/json/json_database.dart';

class JsonNovelDatabase extends JsonDatabase<Novel> {
  JsonNovelDatabase()
    : super(JsonIO.instance, '${Directory.current.path}/main.db.json');

  @override
  Future<void> delete(Novel value) async {
    final list = await getAll();
    final index = list.indexWhere((e) => e.title == value.title);
    if (index == -1) return;
    await save(list);
  }

  @override
  Future<void> update(Novel value) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Novel fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(Novel value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
