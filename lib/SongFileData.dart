import 'package:audiotags/audiotags.dart';
import 'package:flutter/widgets.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';

class SongFileData{
  String trackName = "";
  String albumArtistName = "";
  String albumName = "";
  String fileName = "";
  Image albumArt = Image(image: AssetImage("assets/music_note.png"), width: 256, height: 256,);
  String filePath = "";

  Future<void> setValuesFromSongModel(SongModel songModel) async {
    Tag? tag = await AudioTags.read(songModel.data);
    if(tag != null){
      trackName = tag.title ?? "";
      albumArtistName = tag.albumArtist ?? "";
      albumName = tag.album ?? "";
      fileName = songModel.data.split("/").last;
      albumArt = tag.pictures.isNotEmpty ? Image.memory(tag.pictures.first.bytes, width: 256, height: 256,) : Image(image: AssetImage("assets/music_note.png"), width: 256, height: 256,);
      filePath = songModel.data;
    }
  }

  SongFileData();

  SongFileData.populate(this.trackName, this.albumArtistName, this.albumName, this.fileName, this.albumArt, this.filePath);
}