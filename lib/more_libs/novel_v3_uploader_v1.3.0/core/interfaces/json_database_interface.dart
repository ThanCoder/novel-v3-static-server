import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:than_pkg/t_database/data_io.dart';

import 'database_interface.dart';

abstract class JsonDatabaseInterface<T> extends DatabaseInterface<T> {
  final JsonIO io;

  JsonDatabaseInterface({required super.root, required super.storage})
    : io = JsonIO.instance;

  Map<String, dynamic> toMap(T value);
  T fromMap(Map<String, dynamic> map);
  Future<String> getDBContent(String sourceRoot);

  @override
  Future<List<T>> getAll({Map<String, dynamic> query = const {}}) async {
    List<T> list = [];
    try {
      final content = await getDBContent(root);
      // print(content);
      List<dynamic> mapList = jsonDecode(content);
      list = mapList.map((map) => fromMap(map)).toList();
    } catch (e) {
      debugPrint('[JsonDatabaseInterface:getAll]: ${e.toString()}');
    }
    return list;
  }
}
