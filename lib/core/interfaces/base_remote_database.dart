abstract class BaseRemoteDatabase<T> {
  Future<List<T>> getAll();
  Future<void> add(T value);
  Future<void> update(T value);
  Future<void> delete(T value);
}
