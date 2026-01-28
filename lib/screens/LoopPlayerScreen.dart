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

  @override
  void initState() {
    super.initState();
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      songFileData = context.watch<SongProvider>().songFileData;
    });

    context.read<AudioPlayerProvider>().setSong(songFileData);

    bool _isPaused = context.watch<AudioPlayerProvider>().isPaused;
    bool _isPlaying = context.watch<AudioPlayerProvider>().isPlaying;
    bool _isLooping = context.watch<AudioPlayerProvider>().isLooping;


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
                  playLogic: context.read<AudioPlayerProvider>().playLogic,
                  toggleLoop: context.read<AudioPlayerProvider>().toggleLoop,
                  restart: context.read<AudioPlayerProvider>().restart,
                  searchPosition: context.read<AudioPlayerProvider>().searchPosition,
                  isPlaying: _isPlaying,
                  isLooping: _isLooping,
                  isPaused: _isPaused,
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