import 'package:flutter/material.dart';

class TerminalApp {
  static final TerminalApp instance = TerminalApp._();
  TerminalApp._();
  factory TerminalApp() => instance;

  static bool isShowDebugLog = true;
  late String Function() getExecPath;
  late String Function() getBashCommand;

  Future<void> init({
    bool isShowDebugLog = true,
    required String Function() getExecPath,
    required String Function() getBashCommand,
  }) async {
    TerminalApp.isShowDebugLog = isShowDebugLog;
    this.getExecPath = getExecPath;
    this.getBashCommand = getBashCommand;
  }

  static void showDebugLog(String message, {String? tag}) {
    if (!isShowDebugLog) return;
    if (tag != null) {
      debugPrint('[$tag]: $message');
    } else {
      debugPrint(message);
    }
  }

  static String get getErrorLog {
    return ''' await TerminalApp.instance.init''';
  }
}
