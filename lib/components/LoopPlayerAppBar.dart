import 'package:flutter/material.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

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
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    final List<Widget> bar = [];

    bar.add(
      Row(
        children: [
          IconButton(
            onPressed: back
                ? () => Navigator.pop(context)
                : openMenu,
            icon: Icon(back ? Icons.arrow_back : Icons.menu, size: 40, color: colors.accent,),
          ),
          Text(text, style: TextStyle(fontSize: 32, color: colors.accent)),
        ],
      )
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
      backgroundColor: colors.appBar,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 0,
        children: bar,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
