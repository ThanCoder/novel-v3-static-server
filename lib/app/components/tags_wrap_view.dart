import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TagsWrapView extends StatefulWidget {
  String title;
  String values;
  List<String> allTags;
  void Function(String value)? onDeleted;
  void Function(String value)? onNewAdded;
  void Function(String value)? onClicked;
  void Function(String values)? onApply;
  TagsWrapView({
    super.key,
    required this.title,
    required this.values,
    this.allTags = const [],
    this.onNewAdded,
    this.onDeleted,
    this.onClicked,
    this.onApply,
  });

  @override
  State<TagsWrapView> createState() => _TagsWrapViewState();
}

class _TagsWrapViewState extends State<TagsWrapView> {
  List<String> get _getList {
    return widget.values.split(',').where((name) => name.isNotEmpty).toList();
  }

  List<Widget> _getWidgetList() {
    return List.generate(_getList.length, (index) {
      final name = _getList[index];
      return TChip(
        title: Text(name),
        onDelete: widget.onDeleted != null
            ? () => widget.onDeleted!(name)
            : null,
        onClick: widget.onClicked != null
            ? () => widget.onClicked!(name)
            : null,
      );
    });
  }

  void _addTags() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TRenameDialog(
        cancelText: 'Close',
        submitText: 'New',
        onCheckIsError: (text) {
          if (_getList.contains(text)) {
            return 'Already Exists!';
          }
          return null;
        },
        onSubmit: (text) {
          if (widget.onNewAdded == null) {
            return;
          }
          widget.onNewAdded!(text);
        },
      ),
    );
  }

  Widget _addButton() {
    if (widget.onNewAdded == null) {
      return const SizedBox.shrink();
    }
    return IconButton(
      color: Colors.green,
      onPressed: _addTags,
      icon: const Icon(Icons.add_circle_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(widget.title),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [..._getWidgetList(), _addButton()],
        ),
      ],
    );
  }
}
