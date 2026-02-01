import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopplayer/Prefs.dart';
import 'package:loopplayer/components/LoopPlayerAppBar.dart';
import 'package:loopplayer/components/PickerEntry.dart';
import 'package:loopplayer/components/SideMenu.dart';
import 'package:loopplayer/themes/AppThemeTemplate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsScreenState();
  }
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _isMenuOpen = false;

  late bool _repeatDefault;
  late bool _autoPlay;
  late int _precisionMilis;
  late int _pauseBetweenLoops;
  
  SharedPreferences prefs = AppPreferences.prefs;

  void _openMenu() {
    setState(() {
      _isMenuOpen ? _isMenuOpen = false : _isMenuOpen = true;
    });
  }
  
  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async{
    _repeatDefault = prefs.getBool("repeatDefault") ?? true;
    _autoPlay = prefs.getBool("autoPlay") ?? true;
    _precisionMilis = prefs.getInt("precisionMilis") ?? 2000;
    _pauseBetweenLoops = prefs.getInt("precisionMilis") ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeTemplate>()!;
    return Scaffold(
      appBar: LoopPlayerAppBar(
        back: false,
        openMenu: _openMenu,
        text: "Ajustes",
      ),
      body: Stack(
        children: [
          Column(
            children: [MenuEntry(
              startIcon: Icon(Icons.play_arrow, color: colors.accent),
              text: "Reproduccion automatica al abrir",
              onTap: () {
                setState(() {
                  _autoPlay = !_autoPlay;
                  prefs.setBool("autoplay", _autoPlay);
                });
              },
              buttons: [
                Switch(
                  value: _autoPlay,
                  onChanged: (value) {
                    setState(() {
                      _autoPlay = !_autoPlay;
                      prefs.setBool("autoplay", _autoPlay);
                    });
                  },
                ),
              ],
            ),
              MenuEntry(
                startIcon: Icon(Icons.repeat, color: colors.accent),
                text: "Siempre empezar bucle",
                onTap: () {
                  setState(() {
                    _repeatDefault = !_repeatDefault;
                    prefs.setBool("repeatDefault", _repeatDefault);
                  });
                },
                buttons: [
                  Switch(
                    value: _repeatDefault,
                    onChanged: (value) {
                      setState(() {
                        _repeatDefault = !_repeatDefault;
                        prefs.setBool("repeatDefault", _repeatDefault);
                      });
                    },
                  ),
                ],
              ),
              MenuEntry(
                startIcon: Icon(Icons.settings_ethernet, color: colors.accent),
                text: "Precision de movimiento (milis)",
                onTap: () {
                  final TextEditingController textController =
                      TextEditingController();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Precision (milis)"),
                        content: TextField(
                          controller: textController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hint: Text(_precisionMilis.toString())),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              prefs.setInt("precisionMilis", _precisionMilis);
                              setState(() {
                                _precisionMilis = int.parse(textController.text);
                              });
                            },
                            child: Text("Enviar"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              MenuEntry(
                startIcon: Icon(
                  Icons.motion_photos_paused,
                  color: colors.accent,
                ),
                text: "Pausa entre bucles (milis)",
                onTap: () {
                  final TextEditingController textController =
                  TextEditingController();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Pausa entre bucles (milis)"),
                        content: TextField(
                          controller: textController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hint: Text(_pauseBetweenLoops.toString())),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              prefs.setInt("pauseBetweenLoops", _pauseBetweenLoops);
                              setState(() {
                                _pauseBetweenLoops = int.parse(textController.text);
                              });
                            },
                            child: Text("Enviar"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

            ],
          ),
          if (_isMenuOpen)
            Positioned.fill(
              child: Container(color: Colors.black.withAlpha(127)),
            ),
          SideMenu(isMenuOpen: _isMenuOpen),
        ],
      ),
    );
  }
}
