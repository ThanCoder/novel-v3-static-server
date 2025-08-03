import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_v3_static_server/more_libs/novel_v3_uploader_v1.2.0/services/server_file_services.dart';
import 'package:t_widgets/t_widgets.dart';

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
      setState(() {
        outputLines.clear();
        outputLines.add("Running: git status");
      });

      // Step 0: git status
      var status = await Process.run('git', [
        'status',
      ], workingDirectory: ServerFileServices.getRootPath());

      setState(() {
        outputLines.add("git status => ${status.exitCode}");
        outputLines.add('Log: ${status.stdout}');
        outputLines.add('Error: ${status.stderr}');
      });

      // Step 1: git add .
      setState(() {
        outputLines.add("Running: git add .'");
      });

      var addResult = await Process.run('git', [
        'add',
        '.',
      ], workingDirectory: ServerFileServices.getRootPath());

      setState(() {
        outputLines.add("git add . => ${addResult.exitCode}");
        outputLines.add('Log: ${addResult.stdout}');
        outputLines.add('Error: ${addResult.stderr}');
      });

      // Step 2: git commit -m 'update'
      setState(() {
        outputLines.add("Running: git commit -m 'update'");
      });

      var commitResult = await Process.run('git', [
        'commit',
        '-m',
        '"update"',
      ], workingDirectory: ServerFileServices.getRootPath());

      setState(() {
        outputLines.add("git commit => ${commitResult.exitCode}");
        outputLines.add('Log: ${commitResult.stdout}');
        outputLines.add('Error: ${commitResult.stderr}');
      });
      // Step 3: git push -u origin main
      var pushResult = await Process.run('git', [
        'push',
        '-u',
        'origin',
        'main',
      ], workingDirectory: ServerFileServices.getRootPath());

      setState(() {
        outputLines.add("git push => ${pushResult.exitCode}");
        outputLines.add('Log: ${pushResult.stdout}');
        outputLines.add('Error: ${pushResult.stderr}');
      });

      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
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
                    title: 'Git Add',
                    trailing: IconButton(
                      onPressed: () {},
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
