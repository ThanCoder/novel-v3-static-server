import 'dart:async';

import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.3.0/models/novel.dart';
import 'package:t_widgets/widgets/t_search_field.dart';

import '../components/wrap_list_tile.dart';


class NovelSearchScreen extends StatefulWidget {
  List<Novel> list;
  void Function(String title, List<Novel> list) onClicked;
  Widget? Function(BuildContext context, Novel novel) listItemBuilder;
  NovelSearchScreen({
    super.key,
    required this.list,
    required this.listItemBuilder,
    required this.onClicked,
  });

  @override
  State<NovelSearchScreen> createState() => _NovelSearchScreenState();
}

class _NovelSearchScreenState extends State<NovelSearchScreen> {
  List<Novel> resultList = [];
  bool isSearched = false;
  Timer? _delaySearchTimer;

  @override
  void dispose() {
    _delaySearchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TSearchField(
          autofocus: false,
          onChanged: (text) {
            if (_delaySearchTimer?.isActive ?? false) {
              _delaySearchTimer?.cancel();
            }
            _delaySearchTimer = Timer(
              Duration(milliseconds: 500),
              () => _onSearch(text),
            );
          },
          onCleared: () {
            setState(() {
              isSearched = false;
            });
          },
        ),
      ),
      body: _searchChanged(),
    );
  }

  Widget _getResultList() {
    return ListView.separated(
      itemBuilder: (context, index) =>
          widget.listItemBuilder(context, resultList[index]),
      separatorBuilder: (context, index) => Divider(),
      itemCount: resultList.length,
    );
  }

  Widget _getHomeList() {
    final authorList = widget.list.map((e) => e.author).toSet().toList();
    final transList = widget.list.map((e) => e.translator).toSet().toList();
    final mcList = widget.list.map((e) => e.mc).toSet().toList();
    final tagsList = widget.list.expand((e) => e.getTags).toSet().toList();
    return CustomScrollView(
      slivers: [
        // author
        SliverToBoxAdapter(
          child: WrapListTile(
            title: Text('Author'),
            list: authorList,
            onClicked: (name) {
              final res = widget.list.where((e) => e.author == name).toList();
              widget.onClicked(name, res);
            },
          ),
        ),
        // translator
        SliverToBoxAdapter(
          child: WrapListTile(
            title: Text('Translator'),
            list: transList,
            onClicked: (name) {
              final res = widget.list
                  .where((e) => e.translator == name)
                  .toList();
              widget.onClicked(name, res);
            },
          ),
        ),
        // tags
        SliverToBoxAdapter(
          child: WrapListTile(
            title: Text('Tags'),
            list: tagsList,
            onClicked: (name) {
              final res = widget.list
                  .where((e) => e.getTags.contains(name))
                  .toList();
              widget.onClicked(name, res);
            },
          ),
        ),

        // mc
        SliverToBoxAdapter(
          child: WrapListTile(
            title: Text('MC'),
            list: mcList,
            onClicked: (name) {
              final res = widget.list.where((e) => e.mc == name).toList();
              widget.onClicked(name, res);
            },
          ),
        ),
      ],
    );
  }

  Widget _searchChanged() {
    if (isSearched) {
      if (resultList.isEmpty) {
        return Center(child: Text('မတွေ့ပါ....'));
      }
      return _getResultList();
    }
    return _getHomeList();
  }

  void _onSearch(String text) {
    if (text.isEmpty) {
      setState(() {
        isSearched = false;
      });
      return;
    }
    // search
    resultList = widget.list.where((e) {
      // search title
      if (e.title.toLowerCase().contains(text.toLowerCase())) {
        return true;
      }
      // search author
      if (e.author.toLowerCase().contains(text.toLowerCase())) {
        return true;
      }
      // search mc
      if (e.mc.toLowerCase().contains(text.toLowerCase())) {
        return true;
      }
      return false;
    }).toList();
    setState(() {
      isSearched = true;
    });
  }
}
