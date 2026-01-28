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
  Duration? start = null;
  Duration? end = null;

  Future<void> setValuesFromSongModel(SongModel songModel) async {
    print("actualizando segun songmodel");
    Tag? tag = await AudioTags.read(songModel.data);
    if(tag != null){
      print("hay tag");
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

  @override
  String toString() {
    return "$trackName, $albumArtistName, $albumName, $fileName, $filePath";
  }
}