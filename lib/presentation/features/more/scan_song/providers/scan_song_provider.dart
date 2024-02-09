import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_compress/json_compress.dart';

import '../models/scanned_song_model.dart';

enum ScanSongState{
  loading,
  findSong,
  failed
}

class ScanSongProvider extends ChangeNotifier{
  

  ScanSongState scanSatate = ScanSongState.loading;
  ScannedSongModel? scannedSong;


  void onDetectSong(String? rawValue){
    try {
      final songMap= decompressJson(jsonDecode(rawValue!));
      final scannedSongModel = ScannedSongModel.fromMap(songMap);
      scannedSong = scannedSongModel;
      scanSatate = ScanSongState.findSong;
      notifyListeners();
    } catch (e) {
      scanSatate = ScanSongState.failed;
      notifyListeners();
    }
  }

  void cancelDetectedSong(){
    scannedSong = null;
    scanSatate = ScanSongState.loading;
    notifyListeners();
  }


}