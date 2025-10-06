import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:than_pkg/services/t_map.dart';

import '../../novel_v3_uploader.dart';

class LocalUploaderFileDatabase extends LocalDatabaseInterface<UploaderFile> {
  LocalUploaderFileDatabase()
    : super(
        root: '${NovelV3Uploader.instance.getLocalServerPath()}/content_db',
        storage: Storage(
          root: '${NovelV3Uploader.instance.getLocalServerPath()}/files',
        ),
      );

  @override
  Future<List<UploaderFile>> getAll({
    Map<String, dynamic> query = const {},
  }) async {
    List<UploaderFile> list = [];
    try {
      final id = query.getString(['id']);
      final content = await getDBContent('$root/$id.db.json');
      // print(content);
      List<dynamic> mapList = jsonDecode(content);
      list = mapList.map((map) => fromMap(map)).toList();
    } catch (e) {
      debugPrint('[LocalUploaderFileDatabase:getAll]: ${e.toString()}');
    }
    return list;
  }

  @override
  Future<void> add(UploaderFile value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  UploaderFile fromMap(Map<String, dynamic> map) {
    return UploaderFile.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(UploaderFile value) {
    return value.toMap();
  }

  @override
  Future<void> update(String id, UploaderFile value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
