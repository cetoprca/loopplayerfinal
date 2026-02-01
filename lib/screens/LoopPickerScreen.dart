import 'package:flutter/material.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/model/LoopData.dart';
import 'package:loopplayer/providers/LoopProvider.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';
import 'package:provider/provider.dart';

import '../components/PickerEntry.dart';

class LoopPicker extends StatefulWidget{
  const LoopPicker({super.key, required this.back});
  final bool back;

  @override
  State<StatefulWidget> createState() {
    return LoopPickerState();
  }
}

class LoopPickerState extends State<LoopPicker>{
  bool _isMenuOpen = false;
  late final bool _back;
  late bool _favorites;

  @override
  void initState() {
    super.initState();
    _back = widget.back;
    _favorites = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoopProvider>().fetchLoops();
    });
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  List<MenuEntry> _entries(List<LoopData> loops, BuildContext context){
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    List<MenuEntry> entries = [];
    for(LoopData loopData in loops){
      entries.add(
          MenuEntry(
              startIcon: Icon(Icons.music_note, color: colors.accent,),
              text: loopData.songFileData!.trackName!.isEmpty ? loopData.songFileData!.fileName! : loopData.songFileData!.trackName!,
              buttons: [
                IconButton(onPressed: (){
                  context.read<LoopProvider>().removeLoop(loopData.id!);
                }, icon: Icon(Icons.delete), color: colors.entrySeparator,),
                IconButton(onPressed: (){
                  setState(() {
                    context.read<LoopProvider>().toggleFavorite(loopData);
                  });
                }, icon: Icon(loopData.favorite! ? Icons.favorite : Icons.favorite_border), color: loopData.favorite! ? colors.favoriteButtonEnabled : colors.favoriteButtonDisabled,),

              ],
              onTap: (){
                context.read<SongProvider>().changeSong(loopData.songFileData!);
                if(!_back){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoopPlayer()));
                }else{
                  Navigator.pop(context);
                }
              })
      );
    }

    return entries;
  }

  @override
  Widget build(BuildContext context) {
    final loopProvider = Provider.of<LoopProvider>(context);

    List<LoopData> loops = _favorites ? loopProvider.favoriteLoops : loopProvider.loops;

    return Scaffold(
      appBar: LoopPlayerAppBar(back: _back, openMenu: _openMenu, text: "Selector de Bucles", buttons: [
        IconButton(onPressed: (){
          setState(() {
            _favorites = !_favorites;
          });
        }, icon: Icon(_favorites ? Icons.favorite : Icons.favorite_border))
      ],),
      body: Stack(
        children: [
          Container(color: Colors.black.withAlpha(0),),
          loops.isNotEmpty ? SingleChildScrollView(
            child: Column(
                children: _entries(loops, context)
            ),
          )
              :
          Center(child: Text("No hay bucles"),),
          if(_isMenuOpen) Positioned.fill(child: Container(color: Colors.black.withAlpha(127),)),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}