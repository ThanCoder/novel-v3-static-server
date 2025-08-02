import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader/models/helper_file.dart';
import 'package:t_widgets/widgets/t_cache_image.dart';

class HelperContentScreen extends StatelessWidget {
  HelperFile helper;
  HelperContentScreen({super.key, required this.helper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(helper.title)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Text(helper.desc)),
          SliverToBoxAdapter(child: const Divider()),
          SliverList.builder(
            itemCount: helper.imagesUrl.length,
            itemBuilder: (context, index) {
              final url = helper.imagesUrl[index];
              return TCacheImage(url: url);
            },
          ),
        ],
      ),
    );
  }
}
