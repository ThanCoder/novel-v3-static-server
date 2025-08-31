import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/sources/local_data_source.dart';
import '../models/index.dart';

class UploaderFileLocalDataSource extends LocalDataSource<UploaderFile> {
  UploaderFileLocalDataSource(super.io, {required super.fileSource});

  String getRooPath(String novelId) => '${fileSource.root}/$novelId.db.json';
  String? currentPath;

  @override
  Future<List<UploaderFile>> getAll({String? id}) async {
    if (id == null) return [];
    currentPath = getRooPath(id);
    try {
      List<dynamic> jsonList = jsonDecode(await io.read(currentPath!));
      return jsonList.map((e) => fromMap(e)).toList();
    } catch (e) {
      debugPrint('[UploaderFileLocalDataSource:getAll]: ${e.toString()}');
    }
    return super.getAll(id: id);
  }

  @override
  Future<void> save(List<UploaderFile> list) async {
    if (currentPath == null) return;
    final jsonList = list.map((e) => toMap(e)).toList();
    final contents = JsonEncoder.withIndent(' ').convert(jsonList);
    await io.write(currentPath!, contents);
    notify();
  }

  @override
  Future<void> delete(UploaderFile value) async {
    currentPath = getRooPath(value.novelId);
    final list = await getAll(id: value.novelId);
    final index = list.indexWhere((e) => e.id == value.id);
    if (index == -1) return;
    list.removeAt(index);
    await save(list);
  }

  @override
  Future<void> add(UploaderFile value) async {
    currentPath = getRooPath(value.novelId);
    final list = await getAll(id: value.novelId);
    list.add(value);
    await save(list);
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
  Future<void> update(UploaderFile value) async {
    currentPath = getRooPath(value.novelId);
    final list = await getAll(id: value.novelId);
    final index = list.indexWhere((e) => e.id == value.id);
    if (index == -1) return;
    list[index] = value;
    await save(list);
  }
}
