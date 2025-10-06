import '../../novel_v3_uploader.dart';

class ApiUploaderFileHistoryDatabase
    extends ApiDatabaseInterface<UploaderFile> {
  ApiUploaderFileHistoryDatabase()
    : super(
        root:
            '${NovelV3Uploader.instance.getApiServerUrl()}/uploader-file-history.db.json',
        storage: Storage(
          root: '${NovelV3Uploader.instance.getApiServerUrl()}/files',
        ),
      );

  @override
  UploaderFile fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  String getId(UploaderFile value) {
    // TODO: implement getId
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toMap(UploaderFile value) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
