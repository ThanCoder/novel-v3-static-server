import 'package:flutter/material.dart';
import 'terminal_screen.dart';

class TerminalButton extends StatelessWidget {
  const TerminalButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TerminalScreen()),
        );
      },
      icon: Icon(Icons.terminal),
    );
  }
}
