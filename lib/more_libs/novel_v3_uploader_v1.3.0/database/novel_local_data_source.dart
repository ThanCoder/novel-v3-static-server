import '../core/sources/local_data_source.dart';
import '../models/novel.dart';

class NovelLocalDataSource extends LocalDataSource<Novel> {
  NovelLocalDataSource(super.io, {required super.fileSource});

  @override
  Future<void> delete(Novel value) async {
    final list = await getAll();
    final index = list.indexWhere((e) => e.id == value.id);
    if (index == -1) return;
    list.removeAt(index);

    value.delete();
    await save(list);
  }

  @override
  Future<void> update(Novel value) async {
    final list = await getAll();
    final index = list.indexWhere((e) => e.id == value.id);
    list[index] = value;

    // sort
    // list.sortDate();
    await save(list);
  }

  @override
  Novel fromMap(Map<String, dynamic> map) {
    return Novel.fromMap(map);
  }

  @override
  Map<String, dynamic> toMap(Novel value) {
    return value.toMap;
  }
}
