import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer();

  void stop() {
    audioPlayer.stop();
  }

  void play(String url) {
    audioPlayer.stop();
    Source source = UrlSource(url);
    audioPlayer.setSourceUrl(url);
    audioPlayer.play(source);
  }
}
