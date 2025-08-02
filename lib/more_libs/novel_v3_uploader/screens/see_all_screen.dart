import 'package:flutter/material.dart';

class SeeAllScreen<T> extends StatelessWidget {
  Widget title;
  List<T> list;
  Widget? Function(BuildContext context, int index) itemBuilder;
  SeeAllScreen({
    super.key,
    required this.title,
    required this.list,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 180,
          mainAxisExtent: 200,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
