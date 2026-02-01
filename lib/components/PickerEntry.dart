import 'package:flutter/material.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class MenuEntry extends StatelessWidget{
  const MenuEntry({super.key, required this.text, this.buttons, required this.onTap, this.startIcon});
  final Icon? startIcon;
  final String text;
  final List<Widget>? buttons;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 5,
            color: colors.entrySeparator,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colors.pickerEntry
            ),
            child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(startIcon != null) startIcon!,
                Expanded(
                  child: Text(text, overflow: TextOverflow.ellipsis,),
                ),
                if(buttons != null)
                  Row(
                    children: buttons!,
                  )
              ],
            ),
          ),
        ],
      ),
      onTap: () => onTap(),
    );
  }

}