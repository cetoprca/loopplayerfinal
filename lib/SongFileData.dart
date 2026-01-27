import 'package:flutter/widgets.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';

class SongFileData{
  String trackName = "";
  String albumArtistName = "";
  String albumName = "";
  String fileName = "";
  Image albumArt = Image(image: AssetImage("assets/music_note.png"));

  void setValuesFromSongModel(){
  }

  SongFileData();

  SongFileData.populate(this.trackName, this.albumArtistName, this.albumName, this.fileName, this.albumArt);
}