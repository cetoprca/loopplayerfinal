import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:loopplayer/screens/AudioPickerScreen.dart';
import 'package:loopplayer/screens/LoopPickerScreen.dart';
import 'package:loopplayer/main.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/screens/SettingsScreen.dart';
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
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  SongFileData _songFileData = SongFileData();

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  Duration _startPosition = Duration.zero;
  Duration _endPosition = Duration.zero;

  bool _isPaused = false;
  bool _isPlaying = false;
  bool _isLooping = false;

  bool _init = false;

  FlutterSoundPlayer get player => _player;
  bool get isPaused => _isPaused;
  bool get isPlaying => _isPlaying;
  bool get isLooping => _isLooping;

  void setSong(SongFileData songFileData){
    if(_init){
      _songFileData = songFileData;
      notifyListeners();
    }
  }

  void setStart(int second){
    _startPosition = Duration(seconds: second);
    notifyListeners();
  }

  void setEnd(int second){
    _endPosition = Duration(seconds: second);
    notifyListeners();
  }

  Future<void> initPlayer() async{
    if(!_init){
      print("Inicializando player...");

      await _player.openPlayer();
      _player.setSubscriptionDuration(Duration(milliseconds: 100));

      _player.onProgress!.listen((event) {
        _position = event.position;
        _duration = event.duration;

        // if(_position >= _endPosition){
        //   if(_isLooping) {
        //     _player.seekToPlayer(_startPosition);
        //   }else{
        //     _player.stopPlayer();
        //     _isPlaying = false;
        //   }
        // }
      });

      _init = true;
      print("Player inicializado");
    }
  }

  Future<void> startPlayer() async{
    if(!_init){
      return;
    }
    print("Empezando reproduccion de ${_songFileData.filePath}");

    if(isPlaying){
      _player.stopPlayer();
    }

    if(_songFileData.filePath.isEmpty){
      return;
    }

    await _player.startPlayer(
        fromURI: _songFileData.filePath,
        whenFinished:(){
          if(_isLooping){
            _player.seekToPlayer(_startPosition);
          }else{
            _isPlaying = false;
          }
        }
    );

    _endPosition = _duration;
    await _player.seekToPlayer(_startPosition);

    _isPlaying = true;
    notifyListeners();
    print("Reproduccion empezada");
  }

  Future<void> playLogic() async{
    print("Click en pause/play");

    if(!_isPlaying){
      startPlayer();
    }
    if(_isPlaying){
      if(!_isPaused){
        await _player.pausePlayer();
        _isPaused = true;
      }else{
        await _player.resumePlayer();
        _isPaused = false;
      }
    }
    notifyListeners();
  }

  Future<void> restart() async{
    await _player.seekToPlayer(_startPosition);
    notifyListeners();
  }

  void toggleLoop(){
    _isLooping ? _isLooping = false : _isLooping = true;
    notifyListeners();
  }

  Future<void> searchPosition(int precision) async{
    await _player.seekToPlayer(_position + Duration(milliseconds: precision));
    notifyListeners();
  }
}