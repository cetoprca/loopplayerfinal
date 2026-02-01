import 'package:flutter/material.dart';
import 'package:loopplayer/components/FileOrAssetImage.dart';
import 'package:loopplayer/model/SongFileData.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';

class AudioInfoView extends StatelessWidget{
  final SongFileData songFileData;

  const AudioInfoView({super.key, required this.songFileData});

  Container getContainer(String text, BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;

    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.audioDataBackground),
        padding: EdgeInsets.all(5),
        constraints: BoxConstraints(
            maxWidth: 350
        ),
        child: Text(
            text,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
            color: colors.audioDataText
        ),
        )
    );
  }
  List<Widget> _buildTexts(BuildContext context) {
    // Si no hay trackName, mostramos solo el archivo
    List<Widget> info = [];
    List<Widget> texts = [];

    if (songFileData.trackName!.isEmpty) {
      texts = [getContainer(songFileData.fileName!.isNotEmpty ? songFileData.fileName! : "Seleccione un archivo", context)];
    } else {
      texts = [
        getContainer(songFileData.trackName!, context),
        getContainer(songFileData.albumName!.isEmpty ? "No reconocido" : songFileData.albumName!, context),
        getContainer(songFileData.albumArtistName!.isEmpty ? "No reconocido" : songFileData.albumArtistName!, context)
      ];
    }

    info.add(FileOrAssetImage(filePath: songFileData.albumArt!, fallbackAsset: "assets/music_note.png", width: 256, height: 256));
    info.addAll(texts);

    return info;
  }

  @override
  Widget build(BuildContext context) {
    var info = _buildTexts(context);
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: info,
    );
  }

}