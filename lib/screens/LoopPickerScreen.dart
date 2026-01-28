import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/main.dart';

class LoopPicker extends StatefulWidget{
  const LoopPicker({super.key, required this.back});
  final bool back;

  @override
  State<StatefulWidget> createState() {
    return LoopPickerState();
  }
}

class LoopPickerState extends State<LoopPicker>{
  bool _isMenuOpen = false;

  void _openMenu(){
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoopPlayerAppBar(back: widget.back, goBack: (){}, openMenu: _openMenu, text: "Selector de Bucle"),
      body: Stack(
        children: [
          SideMenu(isMenuOpen: _isMenuOpen)
        ],
      ),
    );
  }
}