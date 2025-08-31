import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/novel.dart';
import '../extensions/novel_extension.dart';

import 'uploader_config_services.dart';

class UploaderNovelServices extends ChangeNotifier {
  final List<Novel> _list = [];

  List<Novel> get getList => _list;
  bool isLoading = false;

  Future<void> initList() async {
    isLoading = true;
    notifyListeners();
    _list.clear();

    final configList = await UploaderConfigServices.getListConfig();
    for (var map in configList) {
      _list.add(Novel.fromMap(map));
    }
    _list.sortDate();

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(Novel novel) async {
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 1));
      // check already exists title
      final findedIndex = _list.indexWhere((e) => e.title == novel.title);
      if (findedIndex != -1) {
        // ရှိနေလို့
        throw Exception('title already exists!');
      }

      _list.insert(0, novel);

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig(mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> delete(Novel novel) async {
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 1));
      // check already exists title
      final findedIndex = _list.indexWhere((e) => e.id == novel.id);
      if (findedIndex == -1) {
        // ရှိနေလို့
        throw Exception('novel not found!');
      }
      _list.removeAt(findedIndex);
      // delete content file db file
      novel.delete();

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig(mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> update(Novel novel) async {
    try {
      isLoading = true;
      notifyListeners();

      final findedIndex = _list.indexWhere((e) => e.id == novel.id);
      if (findedIndex == -1) {
        // ရှိနေလို့
        throw Exception('novel not found!');
      }
      _list[findedIndex] = novel;

      // sort
      _list.sortDate();

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig(mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
