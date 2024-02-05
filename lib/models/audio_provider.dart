import 'package:flutter/material.dart';
import 'package:freemusic/models/songlist.dart';

class AudioProvider extends ChangeNotifier {

  List<List<String>> songLists = SongLists().listData;


}
