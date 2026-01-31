import 'package:flutter/material.dart';
import 'package:loopplayer/model/SongFileData.dart';

class AudioInfoView extends StatelessWidget{
  final SongFileData songFileData;

  const AudioInfoView({super.key, required this.songFileData});

  Container getContainer(String text) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey),
      padding: EdgeInsets.all(5),
      constraints: BoxConstraints(
          maxWidth: 350
      ),
      child: Text(
          text,
          softWrap: true,
          textAlign: TextAlign.center
      )
  );

  List<Widget> _buildTexts() {
    // Si no hay trackName, mostramos solo el archivo
    List<Widget> info = [];
    List<Widget> texts = [];

    if (songFileData.trackName.isEmpty) {
      texts = [getContainer(songFileData.fileName.isNotEmpty ? songFileData.fileName : "Seleccione un archivo")];
    } else {
      texts = [
        getContainer(songFileData.trackName),
        getContainer(songFileData.albumName.isEmpty ? "No reconocido" : songFileData.albumName),
        getContainer(songFileData.albumArtistName.isEmpty ? "No reconocido" : songFileData.albumArtistName)
      ];
    }

    info.add(songFileData.albumArt);
    info.addAll(texts);

    return info;
  }

  @override
  Widget build(BuildContext context) {
    var info = _buildTexts();
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: info,
    );
  }

}