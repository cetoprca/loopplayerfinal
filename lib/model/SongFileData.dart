import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:audiotags/audiotags.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

class SongFileData{
  String? trackName;
  String? albumArtistName;
  String? albumName;
  String? fileName;
  String? filePath;
  String? albumArt;
  int? start;
  int? end;


  SongFileData(this.trackName, this.albumArtistName, this.albumName,
      this.fileName, this.filePath, this.albumArt, this.start, this.end);

  SongFileData.empty(){
    trackName = "";
    albumArtistName = "";
    albumName = "";
    fileName = "";
    albumArt = "assets/music_note.png";
    filePath = "";
    start = 0;
    end = 0;
  }

  factory SongFileData.fromJson(Map<String, dynamic> json){
    return SongFileData(
      json["trackName"],
      json["albumArtistName"],
      json["albumName"],
      json["fileName"],
      json["filePath"],
      json["albumArt"],
      json["start"],
      json["end"],
    );
  }

  Future<void> setFromSongModel(SongModel songModel) async{
    Tag? tag = await AudioTags.read(songModel.data);
    if(tag == null){
      SongFileData.empty();
      return;
    }

    trackName = tag.title ?? "";
    albumArtistName = tag.albumArtist ?? "";
    albumName = tag.album ?? "";
    fileName = songModel.data.split("/").last;
    filePath = songModel.data;
    start = 0;
    end = tag.duration;

    if(tag.pictures.isEmpty){
      albumArt = "assets/music_note.png";
    }else{
      albumArt = await saveCoverArt(fileName!, tag.pictures.first.bytes);
      print(albumArt);
    }
  }

  Future<String> saveCoverArt(String fileName, Uint8List bytes) async{
    final path = await _localPath;
    final file = File("$path/${fileName}_imagen.png");
    await file.writeAsBytes(bytes);
    return await file.exists() ? "$path/${fileName}_imagen.png" : "assets/music_note.png";
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Map<String, dynamic> toJson() {
    return {
      'trackName': trackName,
      'albumArtistName': albumArtistName,
      'albumName': albumName,
      'fileName': fileName,
      'filePath': filePath,
      'albumArt': albumArt,
      'start': start,
      'end': end,
    };
  }

  @override
  String toString() {
    return 'SongFileData{trackName: $trackName, albumArtistName: $albumArtistName, albumName: $albumName, fileName: $fileName, filePath: $filePath, albumArt: $albumArt, start: $start, end: $end}';
  }


}