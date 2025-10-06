import '../../novel_v3_uploader.dart';

class ApiUploaderFileDatabase extends ApiDatabaseInterface<UploaderFile> {
  ApiUploaderFileDatabase()
    : super(
        root: '${NovelV3Uploader.instance.getLocalServerPath()}/content_db',
        storage: Storage(
          root: '${NovelV3Uploader.instance.getLocalServerPath()}/files',
        ),
      );

  @override
  Future<void> add(UploaderFile value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
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
  Future<void> update(String id, UploaderFile value) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
