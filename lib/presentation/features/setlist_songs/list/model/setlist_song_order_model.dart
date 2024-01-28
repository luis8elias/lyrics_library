import 'package:flutter_guid/flutter_guid.dart';

class SetlistSongOrderModel{
  final int indexOrder;
  final Guid setlistSongId;
  final String title;

  SetlistSongOrderModel({
    required this.indexOrder,
    required this.setlistSongId,
    required this.title
  });
}