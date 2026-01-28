import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'SongFileData.dart';

class SongProvider extends ChangeNotifier{
  SongFileData _songFileData = SongFileData();

  SongFileData get songFileData => _songFileData;

  void changeSong(SongModel songModel){
    SongFileData songFileData = SongFileData();
    songFileData.setValuesFromSongModel(songModel);
    _songFileData = songFileData;
    notifyListeners();
  }
}

class ScreenProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setScreen(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class AudioPlayerProvider extends ChangeNotifier{
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isInitialized = false;

  bool isPlaying = false;
  bool isPaused = false;
  bool isLooping = false;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  Duration start = Duration.zero;
  Duration end = Duration.zero;

  SongFileData songFileData = SongFileData();

  Future<void> init() async{
    if(!isInitialized){
      await player.openPlayer();

      player.onProgress!.listen((event){
        position = event.position;
        duration = event.duration;

        if(event.position > end){
          if(isLooping){
            player.seekToPlayer(start);
          }else{
            isPlaying = false;
            isPaused = false;
          }
        }

        notifyListeners();
      });
    }

    isInitialized = true;
  }

  Future<void> play() async{
    if(!isInitialized){
      await init();
    }

    await player.startPlayer(
      fromURI: songFileData.filePath,
      whenFinished: (){
        isPlaying = false;
        isPaused = false;
        notifyListeners();
      }
    );

    isPlaying = true;
    notifyListeners();
  }

  Future<void> stop() async{
    if(!isInitialized){
      await init();
    }

    if(isPlaying){
      await player.stopPlayer();
      isPlaying = false;
    }
    notifyListeners();
  }

  Future<void> pause() async{
    if(!isInitialized){
      await init();
    }

    if(isPlaying){
      if(!isPaused){
        await player.pausePlayer();
        isPaused = true;
      }
    }
    notifyListeners();
  }

  Future<void> resume() async{
    if(!isInitialized){
      await init();
    }

    if(isPlaying){
      if(isPaused){
        await player.resumePlayer();
        isPaused = false;
      }
    }

    notifyListeners();
  }

  Future<void> seek(int second) async{
    if(!isInitialized){
      await init();
    }

    player.seekToPlayer(Duration(seconds: second));
  }

  Future<void> toggleLoop() async{
    isLooping ? isLooping = false : isLooping = true;
  }
}