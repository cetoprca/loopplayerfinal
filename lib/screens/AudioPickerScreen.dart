import 'package:flutter/material.dart';
import 'package:loopplayer/model/SongFileData.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/providers/SongProvider.dart';
import 'package:loopplayer/screens/LoopPlayerScreen.dart';
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

  Future<void> sendToProvider(SongModel songModel) async{
    SongFileData songFileData = SongFileData();
    await songFileData.setValuesFromSongModel(songModel);
    if(mounted) context.read<SongProvider>().changeSong(songFileData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoopPlayerAppBar(back: _back, openMenu: _openMenu, text: "Selector de Archivos",),
      body: Stack(
        children: [
          Container(
            color: _isMenuOpen ? Colors.black.withAlpha((255/2).toInt()) : Colors.black.withAlpha(0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: _songs.length,
                      itemBuilder: (context, index){
                        SongModel songModel = _songs[index];

                        return ListTile(
                          title: GestureDetector(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(songModel.title)
                            ),
                          ),
                          onTap: (){
                            sendToProvider(songModel);
                            
                            if(!_back){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoopPlayer()));
                            }else{
                              Navigator.pop(context);
                            }
                          },
                        );
                      }
                  ),
                )
              ],
            )
          ),
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}

