import 'package:loopplayer/model/SongFileData.dart';

class LoopData{
  int? id;
  bool? favorite;
  SongFileData? songFileData;

  LoopData(this.id, this.favorite, this.songFileData);

  factory LoopData.fromJson(Map<String, dynamic> json){
    return LoopData(
        json["id"],
        json["favorite"] == 1,
        SongFileData.fromJson(json)
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> json = {};

    json["id"] = id!;
    json["favorite"] = favorite! ? 1 : 0;
    json.addAll(songFileData!.toJson());

    return json;
  }

  @override
  String toString() {
    return 'LoopData{id: $id, favorite: $favorite, songFileData: $songFileData}';
  }
}