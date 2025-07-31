import 'package:flutter/cupertino.dart';
import '../extensions/uploader_file_extension.dart';
import '../models/uploader_file.dart';

import 'uploader_config_services.dart';

class UploaderContentFileServices extends ChangeNotifier {
  static String dbName = 'uploader_file.db.json';
  final List<UploaderFile> _list = [];

  List<UploaderFile> get getList => _list;
  bool isLoading = false;

  Future<void> initList() async {
    isLoading = true;
    notifyListeners();
    _list.clear();

    final configList = await UploaderConfigServices.getListConfig(
      dbName: dbName,
    );
    for (var map in configList) {
      _list.add(UploaderFile.fromMap(map));
    }
    _list.sortDate();

    isLoading = false;
    notifyListeners();
  }

  Future<void> add(UploaderFile file) async {
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 1));
      // check already exists title
      final findedIndex = _list.indexWhere((e) => e.title == file.title);
      if (findedIndex != -1) {
        // ရှိနေလို့
        throw Exception('title already exists!');
      }

      _list.insert(0, file);

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig(mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> delete(UploaderFile file) async {
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 1));
      // check already exists title
      final findedIndex = _list.indexWhere((e) => e.title == file.title);
      if (findedIndex == -1) {
        // ရှိနေလို့
        throw Exception('file not found!');
      }
      _list.removeAt(findedIndex);

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig( dbName: dbName,mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> update(UploaderFile file) async {
    isLoading = true;
    notifyListeners();
    try {
      // await Future.delayed(Duration(seconds: 1));
      // check already exists title
      final findedIndex = _list.indexWhere((e) => e.title == file.title);
      if (findedIndex == -1) {
        // ရှိနေလို့
        throw Exception('file not found!');
      }
      _list[findedIndex] = file;

      // sort
      _list.sortDate();

      final mapList = _list.map((e) => e.toMap).toList();
      await UploaderConfigServices.setListConfig( dbName: dbName,mapList, isPrettyJson: true);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
