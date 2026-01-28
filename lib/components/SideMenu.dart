import 'package:flutter/material.dart';
import 'package:loopplayer/providers.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget{
  final bool isMenuOpen;
  const SideMenu({super.key, required this.isMenuOpen});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      top: 0,
      bottom: 0,
      left: isMenuOpen ? 0 : -275,
      child: Container(
        color: Color.fromARGB(255, 85, 85, 85),
        width: 275,
        height: MediaQuery.sizeOf(context).height - kToolbarHeight,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuOption(icon: Icons.folder_outlined, text: "Bucles Guardados", navigateToScreen: (){context.read<ScreenProvider>().setScreen(3);}),
              MenuOption(icon: Icons.audio_file_outlined, text: "Selector de Archivos", navigateToScreen: (){context.read<ScreenProvider>().setScreen(1);}),
              MenuOption(icon: Icons.music_note, text: "Reproductor de Audio", navigateToScreen: (){context.read<ScreenProvider>().setScreen(0);}),
              MenuOption(icon: Icons.settings, text: "Ajustes", navigateToScreen: (){context.read<ScreenProvider>().setScreen(5);}),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuOption extends StatelessWidget{
  final VoidCallback navigateToScreen;
  final IconData icon;
  final String text;
  const MenuOption({super.key, required this.icon, required this.text, required this.navigateToScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 50, 50, 50),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: GestureDetector(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 5,

              children: [
                Icon(icon, size: 32, color: Colors.yellowAccent,),
                SizedBox(
                  width: 1,
                  height: 30,
                  child: VerticalDivider(
                    width: 10,
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                Text(text, style: TextStyle(fontSize: 20, color: Colors.white),)
              ],
            ),
          ),
          onTap: () => navigateToScreen(),
        )
    );
  }
  
}