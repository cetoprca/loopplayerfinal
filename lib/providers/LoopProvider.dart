import 'package:flutter/material.dart';
import 'package:loopplayer/database/DatabaseHelper.dart';
import 'package:loopplayer/model/LoopData.dart';

class LoopProvider extends ChangeNotifier {
  List<LoopData> _loops = [];
  List<LoopData> _favoriteLoops = [];

  bool _isLoading = false;

  List<LoopData> get loops => _loops;
  List<LoopData> get favoriteLoops => _favoriteLoops;
  bool get isLoading => _isLoading;

  // Obtener los tracks desde la base de datos
  Future<void> fetchLoops() async {
    _isLoading = true;
    notifyListeners();

    try {
      _loops.clear();
      _favoriteLoops.clear();
      var jsonLoops = await DatabaseHelper().getLoops();
      for (var json in jsonLoops) {
        LoopData loopData = LoopData.fromJson(json);
        _loops.add(loopData);
      }
      jsonLoops = await DatabaseHelper().getLoopByFavorite(true);
      for (var json in jsonLoops) {
        LoopData loopData = LoopData.fromJson(json);
        _favoriteLoops.add(loopData);
      }
    } catch (e) {
      _loops = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  // Opcional: añadir un track
  Future<void> addLoop(LoopData loop) async {
    try {
      await DatabaseHelper().insertLoop(loop.toJson());
      await fetchLoops();
    } catch (e) {
      print('Error al añadir track: $e');
    }
  }

  // Opcional: borrar un track
  Future<void> removeLoop(int id) async {
    try {
      await DatabaseHelper().deleteById(id);
      _loops.removeWhere((t) => t.id == id);
      await fetchLoops();
    } catch (e) {
      print('Error al borrar track: $e');
    }
  }

  Future<void> toggleFavorite(LoopData loopData) async{
    loopData.favorite = !loopData.favorite!;
    var json = loopData.toJson();
    json.remove("id");
    await DatabaseHelper().updateLoop(json, loopData.id!);
    await fetchLoops();
  }
}