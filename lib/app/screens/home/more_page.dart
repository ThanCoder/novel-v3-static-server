import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/setting_v2.0.0/setting.dart';
import 'package:t_widgets/widgets/t_scrollable_column.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('More')),
      body: TScrollableColumn(
        children: [
          Setting.getThemeSwitcherWidget,
          Setting.getSettingListTileWidget,
          Setting.getCacheManagerWidget,
          Divider(),
          Setting.getCurrentVersionWidget,
        ],
      ),
    );
  }
}
