import 'file_source.dart';

mixin DataSourceChangeListener {
  void onDataSourceChanged();
}

abstract class DataSource<T> {
  final FileSource fileSource;
  bool isPretty;
  DataSource({required this.fileSource, this.isPretty = true});

  Future<void> add(T value);
  Future<List<T>> getAll({String? novelId});
  Future<void> update(T value);
  Future<void> delete(T value);
  // event listener
  final List<DataSourceChangeListener> _listener = [];
  void addListener(DataSourceChangeListener eve) {
    _listener.add(eve);
  }

  void removeListener(DataSourceChangeListener eve) {
    _listener.remove(eve);
  }

  void clearListener() {
    _listener.clear();
  }

  void notify() {
    for (var eve in _listener) {
      eve.onDataSourceChanged();
    }
  }
}
