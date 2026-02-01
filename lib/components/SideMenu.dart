import 'package:flutter/material.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/screens/SettingsScreen.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class SideMenu extends StatelessWidget{
  final bool isMenuOpen;
  const SideMenu({super.key, required this.isMenuOpen});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      top: 0,
      bottom: 0,
      left: isMenuOpen ? 0 : -275,
      child: Container(
        color: colors.background,
        width: 275,
        height: MediaQuery.sizeOf(context).height - kToolbarHeight,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuOption(icon: Icons.folder_outlined, text: "Bucles Guardados", navigateToScreen: LoopPicker(back: false)),
              MenuOption(icon: Icons.audio_file_outlined, text: "Selector de Archivos", navigateToScreen: AudioPicker(back: false)),
              MenuOption(icon: Icons.music_note, text: "Reproductor de Audio", navigateToScreen: LoopPlayer()),
              MenuOption(icon: Icons.settings, text: "Ajustes", navigateToScreen: SettingsScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuOption extends StatelessWidget{
  final Widget navigateToScreen;
  final IconData icon;
  final String text;
  const MenuOption({super.key, required this.icon, required this.text, required this.navigateToScreen});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    return Container(
        decoration: BoxDecoration(
            color: colors.backgroundConstrast,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,

              children: [
                Icon(icon, size: 32, color: colors.accent,),
                SizedBox(
                  width: 1,
                  height: 30,
                  child: VerticalDivider(
                    width: 10,
                    thickness: 2,
                    color: colors.pickerEntry,
                  ),
                ),
                Text(text, style: TextStyle(fontSize: 20, color: colors.entryText),)
              ],
            ),
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => navigateToScreen)),
        )
    );
  }
  
}