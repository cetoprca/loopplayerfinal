import 'package:flutter/material.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/PickerEntry.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/model/SongFileData.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AudioPicker extends StatefulWidget{
  final bool back;
  const AudioPicker({super.key, required this.back});

  @override
  State<StatefulWidget> createState() {
    return AudioPickerState();
  }
}

class AudioPickerState extends State<AudioPicker>{
  final OnAudioQuery onAudioQuery = OnAudioQuery();
  late final bool _back;

  bool _isMenuOpen = false;

  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    _back = widget.back;
    _requestPermission();
  }

  void _requestPermission() async {
    bool hasPermission = await onAudioQuery.permissionsStatus();
    while(!hasPermission) {
      hasPermission = await onAudioQuery.permissionsRequest();

      await [Permission.audio, Permission.photos, Permission.videos, Permission.storage, Permission.manageExternalStorage].request();

      hasPermission = await onAudioQuery.permissionsStatus();
    }

    if (hasPermission) {
      _loadSongs();
    }
  }

  void _loadSongs() async{
    List<SongModel> songs = await onAudioQuery.querySongs();
    setState(() {
      _songs = songs;
    });
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  List<MenuEntry> _entries(List<SongModel> songs, BuildContext context){
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    List<MenuEntry> entries = [];

    for(SongModel songModel in songs){
      entries.add(
          MenuEntry(
              startIcon: Icon(Icons.music_note, color: colors.accent,),
              text: songModel.title,
              onTap: (){
                sendToProvider(songModel);
                if(!_back){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoopPlayer()));
                }else{
                  Navigator.pop(context);
                }
              }
          )
      );
    }

    return entries;
  }

  Future<void> sendToProvider(SongModel songModel) async{
    SongFileData songFileData = SongFileData.empty();
    await songFileData.setFromSongModel(songModel);
    if(mounted) context.read<SongProvider>().changeSong(songFileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoopPlayerAppBar(back: _back, openMenu: _openMenu, text: "Archivos",),
      body: Stack(
        children: [
          _songs.isNotEmpty ?
          SingleChildScrollView(
              child: Column(
                children: _entries(_songs, context),
              )
            )
              :
          Center(child: Text("No hay audios"),),
          if(_isMenuOpen) Positioned.fill(child: Container(color: Colors.black.withAlpha(127),)),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}