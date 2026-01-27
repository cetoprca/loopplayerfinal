import 'package:flutter/material.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'SongFileData.dart';

class SongProvider extends ChangeNotifier{
  final SongFileData _songFileData = SongFileData();

  SongFileData get songFileData => _songFileData;

  void changeSong(SongModel songModel){
    notifyListeners();
  }
}

class ScreenProvider extends ChangeNotifier{

}