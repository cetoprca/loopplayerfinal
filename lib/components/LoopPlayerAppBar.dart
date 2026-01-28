import 'dart:ui';

import 'package:flutter/material.dart';

class LoopPlayerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool back;
  final VoidCallback openMenu;
  final String text;
  final List<IconButton>? buttons;

  const LoopPlayerAppBar({
    super.key,
    required this.back,
    required this.openMenu,
    required this.text,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> bar = [];

    bar.add(
      IconButton(
        onPressed: back
            ? () => Navigator.pop(context)
            : openMenu,
        icon: Icon(back ? Icons.arrow_back : Icons.menu, size: 40),
      ),
    );

    bar.add(
      Text(text, style: const TextStyle(fontSize: 32)),
    );

    if (buttons != null) {
      bar.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: buttons!,
        ),
      );
    }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black45,
      title: Row(
        spacing: 11,
        children: bar,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
