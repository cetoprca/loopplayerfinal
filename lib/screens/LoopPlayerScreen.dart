import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/components/player/AudioInfoView.dart';
import 'package:loopplayer/components/player/PlayerControls.dart';
import 'package:loopplayer/components/player/PositionSlider.dart';
import 'package:loopplayer/components/player/StartEndSlider.dart';
import 'package:loopplayer/database/DatabaseHelper.dart';
import 'package:loopplayer/providers/AudioPlayerProvider.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';
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
    await context.read<AudioPlayerProvider>().restart();
  }

  Future<void> _searchPosition(int milliseconds) async{
    await context.read<AudioPlayerProvider>().searchPosition(milliseconds);
  }

  Future<void> _seek(int second) async{
    await context.read<AudioPlayerProvider>().seek(second);
  }

  Future<void> _changeStart(int second) async{
    await context.read<AudioPlayerProvider>().changeStart(second);
  }

  Future<void> _changeEnd(int second) async{
    await context.read<AudioPlayerProvider>().changeEnd(second);
  }

  Future<void> _moveStartForward(Duration start) async{
    await context.read<AudioPlayerProvider>().changeStart(start.inSeconds + 1);
  }

  Future<void> _moveStartBackward(Duration start) async{
    await context.read<AudioPlayerProvider>().changeStart(start.inSeconds - 1);
  }

  Future<void> _moveEndForward(Duration end) async {
    await context.read<AudioPlayerProvider>().changeEnd(end.inSeconds + 1);
  }

  Future<void> _moveEndBackward(Duration end) async{
    await context.read<AudioPlayerProvider>().changeEnd(end.inSeconds - 1);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    final songFileData = context.watch<SongProvider>().songFileData;

    context.read<AudioPlayerProvider>().changeSong(songFileData);

    bool isPlaying = context.watch<AudioPlayerProvider>().isPlaying;
    bool isPaused = context.watch<AudioPlayerProvider>().isPaused;
    bool isLooping = context.watch<AudioPlayerProvider>().isLooping;
    Duration position = context.watch<AudioPlayerProvider>().position;
    Duration duration = context.watch<AudioPlayerProvider>().duration;

    Duration start = context.watch<AudioPlayerProvider>().start;
    Duration end = context.watch<AudioPlayerProvider>().end;

    bool error = context.watch<AudioPlayerProvider>().error;

    if(error){
      Fluttertoast.showToast(
        msg: "Ha ocurrido un error abriendo el archivo",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG
      );
    }

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
              icon: Icon(Icons.folder_outlined, size: 40,), color: colors.accent,),
          IconButton(
              onPressed: (){
                DatabaseHelper db = DatabaseHelper();

                Map<String, dynamic> loop = songFileData.toJson();

                loop["favorite"] = 0;
                loop["start"] = start.inSeconds;
                loop["end"] = end.inSeconds;

                db.insertLoop(loop);
              },
              icon: Icon(Icons.save, size: 40), color: colors.accent),
          IconButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AudioPicker(back: true)));
              },
              icon: Icon(Icons.audio_file_outlined, size: 40), color: colors.accent),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    AudioInfoView(songFileData: songFileData),
                    SizedBox(height: 20,),
                    PositionSlider(position: position, duration: duration, moveValue: _seek),
                    StartEndSlider(position: start, duration: duration, moveValue: _changeStart, start: true, moveForward: (){_moveStartForward(start);}, moveBackward: (){_moveStartBackward(start);},),
                    StartEndSlider(position: end, duration: duration, moveValue: _changeEnd, start: false, moveForward: (){_moveEndForward(end);}, moveBackward: (){_moveEndBackward(end);}),
                  ],
                )
              ),
              PlayerControls(
                  playLogic: _playLogic,
                  toggleLoop: _toggleLoop,
                  restart: _restart,
                  searchPosition: _searchPosition,
                  isPlaying: isPlaying,
                  isLooping: isLooping,
                  isPaused: isPaused
              )
            ],
          ),
          if(_isMenuOpen) Positioned.fill(child: Container(color: Colors.black.withAlpha(127),)),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}