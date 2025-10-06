import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/ui/novel/desktop_ui/novel_content_screen.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/ui/novel/mobile_ui/novel_content_mobile_screen.dart';
import 'package:than_pkg/than_pkg.dart';

import '../../novel_v3_uploader.dart';

class NovelContentUiSwitcher extends StatelessWidget {
  final Novel novel;
  const NovelContentUiSwitcher({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    //is mobile
    if (TPlatform.isMobile) {
      return NovelContentMobileScreen(novel: novel);
    }
    return NovelContentScreen(novel: novel);
  }
}
