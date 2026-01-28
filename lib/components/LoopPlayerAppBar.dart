import 'package:flutter/material.dart';

class LoopPlayerAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool back;
  final VoidCallback goBack;
  final VoidCallback openMenu;
  final String text;

  const LoopPlayerAppBar({super.key, required this.back, required this.goBack, required this.openMenu, required this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if(back)
            GestureDetector(
                child: Icon(Icons.arrow_back_rounded, size: 40,),
                onTap: () => goBack()
            )
          else
            GestureDetector(
                child: Icon(Icons.menu, size: 40,),
                onTap: () => openMenu()
            ),
          SizedBox(width: 40,),
          Text(text)
        ],
      ),
      backgroundColor: Colors.black45,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}