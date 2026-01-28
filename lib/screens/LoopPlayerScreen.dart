import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';
import 'package:loopplayer/components/AudioInfoView.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/PlayerControls.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:loopplayer/providers.dart';
import 'package:provider/provider.dart';

class LoopPlayer extends StatefulWidget{
  const LoopPlayer({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoopPlayerState();
  }
}

class LoopPlayerState extends State<LoopPlayer>{
  late SongFileData songFileData;

  bool _isMenuOpen = false;
  bool _isPlaying = false;
  bool _isPaused = false;
  bool _isLooping = false;

  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  Future<void> _playLogic() async{
    if(_isPlaying){
      if(_isPaused){
        await context.read<AudioPlayerProvider>().resume();
      }else{
        await context.read<AudioPlayerProvider>().pause();
      }
    }else{
      await context.read<AudioPlayerProvider>().play();
    }
  }

  Future<void> _toggleLoop() async{
    await context.read<AudioPlayerProvider>().toggleLoop();
  }

  Future<void> _restart() async{
    await context.read<AudioPlayerProvider>().seek(0);
  }

  Future<void> _searchPosition(int second) async{
    await context.read<AudioPlayerProvider>().seek(_position.inSeconds + second);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      songFileData = context.watch<SongProvider>().songFileData;

      context.read<AudioPlayerProvider>().songFileData = songFileData;

      _isPlaying = context.watch<AudioPlayerProvider>().isPlaying;
      _isPaused = context.watch<AudioPlayerProvider>().isPaused;
      _isLooping = context.watch<AudioPlayerProvider>().isLooping;

      _position = context.watch<AudioPlayerProvider>().position;
    });

    return Scaffold(
      appBar: LoopPlayerAppBar(back: false, goBack: (){}, openMenu: _openMenu, text: "Reproductor de Audio"),
      body: Stack(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AudioInfoView(songFileData: songFileData),
                ),
                PlayerControls(
                    playLogic: _playLogic,
                    toggleLoop: _toggleLoop,
                    restart: _restart,
                    searchPosition: _searchPosition,
                    isPlaying: _isPlaying,
                    isLooping: _isLooping,
                    isPaused: _isPaused
                )
              ],
            ),
          ),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}