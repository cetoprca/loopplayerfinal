import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopplayer/SideMenu.dart';
import 'package:on_audio_query_pluse/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

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

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    _back = widget.back;
    _requestPermission();
  }

  void _requestPermission() async {
    bool hasPermission = await onAudioQuery.permissionsStatus();
    if(!hasPermission) {
      hasPermission = await onAudioQuery.permissionsRequest();

      var permissions = await [Permission.audio, Permission.photos, Permission.videos, Permission.storage, Permission.manageExternalStorage].request();

      hasPermission = permissions.values.every((status) => status.isGranted);
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

  void _goBack(){
    print("Back!");
  }

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: SelectorAppBar(back: _back, goBack: _goBack, openMenu: _openMenu),
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
                            title: Text(songModel.title)
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

class SelectorAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool back;
  final VoidCallback goBack;
  final VoidCallback openMenu;

  const SelectorAppBar({super.key, required this.back, required this.goBack, required this.openMenu});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if(back)
            GestureDetector(
              child: Icon(Icons.arrow_back_rounded, size: 40,),
              onTap: () => goBack()
            )
          else
            GestureDetector(
              child: Icon(Icons.menu, size: 40,),
              onTap: () => openMenu()
            ),
          SizedBox(width: 40,),
          Text("Selector de Archivos")
        ],
      ),
      backgroundColor: Colors.black45,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}