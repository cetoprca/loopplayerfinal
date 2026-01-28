import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';

class AudioInfoView extends StatelessWidget{
  final SongFileData songFileData;
  List<Widget> _info = [];
  List<Widget> _texts = [];

  AudioInfoView({super.key, required this.songFileData});

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

  void _buildTexts() {
    // Si no hay trackName, mostramos solo el archivo
    _info = [];
    if (songFileData.trackName.isEmpty) {
      _texts = [getContainer(songFileData.fileName.isNotEmpty ? songFileData.fileName : "Seleccione un archivo")];
    } else {
      _texts = [
        getContainer(songFileData.trackName),
        getContainer(songFileData.albumName.isEmpty ? "No reconocido" : songFileData.albumName),
        getContainer(songFileData.albumArtistName.isEmpty ? "No reconocido" : songFileData.albumArtistName)
      ];
    }

    _info.add(songFileData.albumArt);
    _info.addAll(_texts);
  }

  @override
  Widget build(BuildContext context) {
    _buildTexts();
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _info,
    );
  }

}