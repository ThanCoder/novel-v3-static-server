// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../data_io.dart';

import '../../core/data_source.dart';

abstract class LocalDataSource<T> extends DataSource<T> {
  final DataIO io;
  LocalDataSource(this.io, {required super.fileSource});

  // map
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T value);

  @override
  Future<List<T>> getAll({String? novelId}) async {
    final source = await io.read(await fileSource.getMainDBPath());
    if (source.isEmpty) return [];
    List<dynamic> jsonList = jsonDecode(source);
    return jsonList.map((e) => fromMap(e)).toList();
  }

  @override
  Future<void> add(T value) async {
    final list = await getAll();
    list.insert(0, value);
    await save(list);
  }

  Future<void> save(List<T> list) async {
    final jsonList = list.map((e) => toMap(e)).toList();
    final dbPath = await fileSource.getMainDBPath();

    if (isPretty) {
      await io.write(dbPath, JsonEncoder.withIndent(' ').convert(jsonList));
    } else {
      await io.write(dbPath, jsonEncode(jsonList));
    }
    notify();
  }
}
