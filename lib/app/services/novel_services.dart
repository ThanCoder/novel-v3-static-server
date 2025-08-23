import 'package:novel_v3_static_server/app/models/novel.dart';
import 'package:novel_v3_static_server/core/interfaces/base_local_database.dart';

class NovelServices {
  final BaseLocalDatabase<Novel> dataSource;
  NovelServices({required this.dataSource});
}
