import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loopplayer/SongFileData.dart';

class AudioInfoView extends StatefulWidget{
  final SongFileData songFileData;

  const AudioInfoView({required this.songFileData});

  @override
  State<StatefulWidget> createState() {
    return _AudioInfoViewState();
  }
}

class _AudioInfoViewState extends State<AudioInfoView> {
  List<Widget> _info = [];
  List<Text> _texts = [];

  void _buildTexts() {
    // Si no hay trackName, mostramos solo el archivo
    setState(() {
      _info = [];
      if (widget.songFileData.trackName.isEmpty) {
        _texts = [Text("Archivo: ${widget.songFileData.fileName}")];
      } else {
        _texts = [
          Text("Cancion: ${widget.songFileData.trackName}"),
          Text("Album: ${widget.songFileData.albumName.isEmpty ? "No reconocido" : widget.songFileData.albumName}"),
          Text("Artista: ${widget.songFileData.albumArtistName.isEmpty ? "No reconocido" : widget.songFileData.albumArtistName}"),
        ];
      }

      _info.add(widget.songFileData.albumArt);
      _info.addAll(_texts);
    });
  }

  @override
  void didUpdateWidget(covariant AudioInfoView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songFileData.fileName != widget.songFileData.fileName ||
        oldWidget.songFileData.trackName != widget.songFileData.trackName ||
        oldWidget.songFileData.albumName != widget.songFileData.albumName ||
        oldWidget.songFileData.albumArtistName != widget.songFileData.albumArtistName) {
      _buildTexts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _info,
    );
  }
}