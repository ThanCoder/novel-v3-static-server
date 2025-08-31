import '../models/index.dart';

import '../core/sources/online_data_source.dart';

class UploaderFileOnlineDataSource extends OnlineDataSource<UploaderFile> {
  UploaderFileOnlineDataSource({required super.fileSource});

  @override
  Future<void> add(UploaderFile value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(UploaderFile value) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  UploaderFile fromMap(Map<String, dynamic> map) {
    return UploaderFile.fromMap(map);
  }

  @override
  Future<void> update(UploaderFile value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
