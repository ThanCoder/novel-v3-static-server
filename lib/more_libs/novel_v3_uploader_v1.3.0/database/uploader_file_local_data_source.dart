import '../core/sources/local_data_source.dart';
import '../models/index.dart';

class UploaderFileLocalDataSource extends LocalDataSource<UploaderFile> {
  UploaderFileLocalDataSource(super.io, {required super.fileSource});

  @override
  Future<void> delete(UploaderFile value) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  UploaderFile fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(UploaderFile value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  @override
  Future<void> update(UploaderFile value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
