import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

import 'terminal_app.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  bool isLoading = false;
  List<String> outputLines = [];

  Future<void> _startUpload() async {
    try {
      final getExecPath = TerminalApp.instance.getExecPath();
      final bashCommand = TerminalApp.instance.getBashCommand();
      // XFCE terminal ဖွင့်ပြီး git command run ခိုင်းမယ်
      await Process.run('xfce4-terminal', [
        '--hold', // command ပြီးသွားတာနဲ့ terminal ပိတ်မသွားအောင်
        '-e',
        "bash -c \"cd $getExecPath && $bashCommand\"",
      ]);
      // git "bash -c \"git add . && git commit -m 'update' && git push -u origin main\"",
    } catch (e) {
      if (!mounted) return;
      TerminalApp.showDebugLog(e.toString());
    }
  }

  void _startUploadConfirm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TConfirmDialog(
        submitText: 'Upload',
        contentText: 'Files တွေကို Upload ပြုလုပ်ချင်ပါသလား?',
        onSubmit: _startUpload,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terminal App'),
        actions: [
          IconButton(
            onPressed: _startUploadConfirm,
            icon: Icon(Icons.cloud_upload_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // loader
                  isLoading ? LinearProgressIndicator() : SizedBox.shrink(),
                  TListTileWithDesc(
                    leading: Icon(Icons.check_box_outline_blank_rounded),
                    title: 'Git Push',
                    trailing: IconButton(
                      onPressed: _startUploadConfirm,
                      icon: Icon(Icons.send),
                    ),
                  ),
                  // divider
                  Divider(),
                ],
              ),
            ),
            SliverList.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: outputLines.length,
              itemBuilder: (context, index) => Text(outputLines[index]),
            ),
          ],
        ),
      ),
    );
  }
}
