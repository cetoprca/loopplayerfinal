import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';

class AudioInfoView extends StatelessWidget{
  final SongFileData songFileData;
  List<Widget> _info = [];
  List<Widget> _texts = [];

  AudioInfoView({super.key, required this.songFileData});

  void _buildTexts() {
    // Si no hay trackName, mostramos solo el archivo
    _info = [];
    if (songFileData.trackName.isEmpty) {
      _texts = [Container(width: 350, child: Text("Archivo: ${songFileData.fileName}", softWrap: true))];
    } else {
      _texts = [
        Text("Cancion: ${songFileData.trackName}", softWrap: true,),
        Text("Album: ${songFileData.albumName.isEmpty ? "No reconocido" : songFileData.albumName}", softWrap: true),
        Text("Artista: ${songFileData.albumArtistName.isEmpty ? "No reconocido" : songFileData.albumArtistName}", softWrap: true),
      ];
    }

    _info.add(songFileData.albumArt);
    _info.addAll(_texts);
  }

  @override
  Widget build(BuildContext context) {
    _buildTexts();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _info,
    );
  }

}