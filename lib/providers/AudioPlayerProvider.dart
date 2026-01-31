import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:loopplayer/model/SongFileData.dart';

class AudioPlayerProvider extends ChangeNotifier{
  final FlutterSoundPlayer player = FlutterSoundPlayer();
  bool isInitialized = false;

  bool isPlaying = false;
  bool isPaused = false;
  bool isLooping = false;
  bool newSong = true;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  Duration start = Duration.zero;
  Duration end = Duration.zero;

  SongFileData _songFileData = SongFileData();

  bool _error = false;

  bool get playing => isPlaying;
  bool get paused => isPaused;
  bool get error => _error;
  Duration get audioPosition => position;

  Future<void> changeSong(SongFileData songFileData) async{
    if(songFileData != _songFileData) {
      _songFileData = songFileData;
      newSong = true;
      await play();
    }
  }

  Future<void> init() async{
    if(!isInitialized){
      await player.openPlayer();
      player.setSubscriptionDuration(Duration(milliseconds: 100));

      player.onProgress!.listen((event){
        position = event.position;
        duration = event.duration;

        if(event.position < start){
          restart();
        }

        if(event.position > end){
          if(isLooping){
            player.seekToPlayer(start);
          }else{
            stop();
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
    if(_songFileData.filePath.isNotEmpty){
      if(!isInitialized){
        await init();
      }

      if(isPlaying){
        await player.stopPlayer();
      }

      _error = false;

      try{
        await player.startPlayer(
            fromURI: _songFileData.filePath,
            whenFinished: (){
              isPlaying = false;
              isPaused = false;
              notifyListeners();
            }
        );
      }on PlatformException{
        _error = true;
        notifyListeners();
        return;
      }

      if(newSong){
        start = _songFileData.start ?? Duration.zero;
        end = _songFileData.end ?? duration;
        newSong = false;
      }

      isPlaying = true;
      isPaused = false;
      notifyListeners();
    }
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

  Future<void> restart() async{
    if(!isInitialized){
      await init();
    }

    await seek(start.inSeconds);
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

  Future<void> searchPosition(int milliseconds) async{
    if(!isInitialized){
      await init();
    }

    player.seekToPlayer(Duration(milliseconds: position.inMilliseconds + milliseconds));
    notifyListeners();
  }

  Future<void> seek(int seconds) async{
    if(!isInitialized){
      await init();
    }

    player.seekToPlayer(Duration(seconds: seconds));
    notifyListeners();
  }

  Future<void> toggleLoop() async{
    isLooping ? isLooping = false : isLooping = true;
    notifyListeners();
  }

  Future<void> changeStart(int second) async{
    if(second < 0 || second > duration.inSeconds){
      return;
    }
    start = Duration(seconds: second);
    notifyListeners();
  }

  Future<void> changeEnd(int second) async{
    if(second < 0 || second > duration.inSeconds){
      return;
    }
    end = Duration(seconds: second);
    notifyListeners();
  }
}