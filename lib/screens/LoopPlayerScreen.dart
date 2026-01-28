import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';
import 'package:loopplayer/components/AudioInfoView.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/PlayerControls.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:loopplayer/providers.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:provider/provider.dart';

class LoopPlayer extends StatefulWidget{
  const LoopPlayer({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoopPlayerState();
  }
}

class LoopPlayerState extends State<LoopPlayer>{
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

  Future<void> _playLogic() async{
    bool isPlaying = context.read<AudioPlayerProvider>().playing;
    bool isPaused = context.read<AudioPlayerProvider>().paused;

    if(isPlaying){
      if(isPaused){
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
    Duration _position = context.read<AudioPlayerProvider>().position;
    await context.read<AudioPlayerProvider>().seek(_position.inSeconds + second);
  }

  Future<void> _seek(int second) async{
    await context.read<AudioPlayerProvider>().seek(second);
  }

  @override
  Widget build(BuildContext context) {
    final songFileData = context.watch<SongProvider>().songFileData;

    context.read<AudioPlayerProvider>().songFileData = songFileData;

    bool _isPlaying = context.watch<AudioPlayerProvider>().isPlaying;
    bool _isPaused = context.watch<AudioPlayerProvider>().isPaused;
    bool _isLooping = context.watch<AudioPlayerProvider>().isLooping;
    Duration _position = context.watch<AudioPlayerProvider>().position;
    Duration _duration = context.watch<AudioPlayerProvider>().duration;

    return Scaffold(
      appBar: LoopPlayerAppBar(
        back: false,
        openMenu: _openMenu,
        text: "LoopPlay",
        buttons: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoopPicker(back: true)));
              },
              icon: Icon(Icons.folder_outlined, size: 40,)),
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.save, size: 40)),
          IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AudioPicker(back: true)));
              },
              icon: Icon(Icons.audio_file_outlined, size: 40)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AudioInfoView(songFileData: songFileData),
              ),
              Expanded(
                  child: Center(
                    child: Slider(
                      min: 0,
                      max: _duration.inSeconds.toDouble(),
                      value: _position.inSeconds.toDouble().clamp(0.0, _duration.inSeconds.toDouble()),
                      onChanged: (value){
                        _seek(value.toInt());
                      }
                    ),
                  )
              ),
              Text("${_position.inSeconds}"),
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
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}