import 'dart:convert';
import 'dart:isolate';

import '../../novel_v3_uploader.dart';

abstract class OnlineDataSource<T> extends DataSource<T> {
  OnlineDataSource({required super.fileSource});

  T fromMap(Map<String, dynamic> map);
  // Map<String, dynamic> toMap(T value);

  @override
  Future<List<T>> getAll({String? novelId}) async {
    List<T> list = [];
    try {
      if (NovelV3Uploader.instance.onDownloadJson == null) {
        throw Exception(NovelV3Uploader.instance.getInitLog);
      }

      final res = await NovelV3Uploader.instance.onDownloadJson!(
        NovelV3Uploader.instance.getRootServerUrl(),
      );
      return await Isolate.run<List<T>>(() async {
        List<dynamic> resList = jsonDecode(res);
        return resList.map((e) => fromMap(e)).toList();
      });
    } catch (e) {
      NovelV3Uploader.instance.showLog(e.toString());
    }
    return list;
  }
}
