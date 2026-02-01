import 'package:flutter/material.dart';
import 'package:loopplayer/model/SongFileData.dart';

class SongProvider extends ChangeNotifier{
  SongFileData _songFileData = SongFileData.empty();

  SongFileData get songFileData => _songFileData;

  void changeSong(SongFileData songFileData){
    _songFileData = songFileData;
    notifyListeners();
  }
}