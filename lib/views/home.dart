import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/configs/config_text.dart';
import 'package:freemusic/configs/songlist.dart';
import 'package:freemusic/widgets/profileDrawer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:freemusic/widgets/searchBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class Home extends StatefulWidget {
  late List<String>? songDetails;
  int currentIndex;
  Home({Key? key, this.songDetails, this.currentIndex = 0}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  TextEditingController searchEditingController = TextEditingController();
  SongLists songLists = SongLists();

  late StreamSubscription<PlayerState> playerStateSubscription;
  late StreamSubscription<Duration> durationSubscription;
  late StreamSubscription<Duration> positionSubscription;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  void previousSong() {
    // Get the total number of songs from SongLists
    int totalSongs = songLists.listData.length;

    // Find the index by comparing the contents of the lists
    int index = -1;
    for (int i = 0; i < totalSongs; i++) {
      if (songLists.listData[i].toString() == widget.songDetails!.toString()) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      int nextIndex = (index - 1) % totalSongs;

      // Update the audio player with the new song details
      widget.songDetails = songLists.listData[nextIndex];
      setAudio();
    }
  }

  void nextSong() {
    // Get the total number of songs from SongLists
    int totalSongs = songLists.listData.length;

    // Find the index by comparing the contents of the lists
    int index = -1;
    for (int i = 0; i < totalSongs; i++) {
      if (songLists.listData[i].toString() == widget.songDetails!.toString()) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      int nextIndex = (index + 1) % totalSongs;

      // Update the audio player with the new song details
      widget.songDetails = songLists.listData[nextIndex];
      setAudio();
    }
  }


  @override
  void initState() {
    super.initState();

    // Listen to states: playing, paused, stopped
    playerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
          if (mounted) {
            setState(() {
              isPlaying = state == PlayerState.playing;
            });
          }
        });

    // Listen to audio duration
    durationSubscription = audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    // Listen to audio position
    positionSubscription =
        audioPlayer.onPositionChanged.listen((newPosition) {
          if (mounted) {
            setState(() {
              position = newPosition;
            });
          }
        });

    // Set initial audio source
    setAudio();
  }

  Future setAudio() async {
    //Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.stop);

    String url = widget.songDetails?[3] ??
        'https://cdn.trendybeatz.com/audio/Burna-Boy-City-Boys-(TrendyBeatz.com).mp3';
    audioPlayer.setSourceUrl(url);

    Source source = UrlSource(url);
    audioPlayer.play(source);
    showToast();

  }

  void showToast() {
    Fluttertoast.showToast(
        fontSize: 17,
        toastLength: Toast.LENGTH_LONG,
        msg: 'Now Playing',
        backgroundColor: ConfigColor.secondaryColor,
        textColor: ConfigColor.primaryColor);
  }

  Widget songTitleAnimation(String text) => SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.66,
        child: Marquee(
          text: text,
          style: GoogleFonts.ubuntu(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ConfigColor.secondaryColor),
          blankSpace: 50,
        ),
      );

  @override
  void dispose() {
    audioPlayer.dispose();
    playerStateSubscription.cancel();
    durationSubscription.cancel();
    positionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //inside a stateful widget
    Image musicImage = Image.network(
      widget.songDetails?[2] ??
          'https://i.scdn.co/image/ab67616d0000b27339550ce4ccf28a1a4b82a443',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
            height: 300,
            child: Image.asset('assets/Images/3d-casual-life-robot-smile.png'));
      },
    );

    return Scaffold(
      backgroundColor: ConfigColor.lightPrimaryColor,
      drawer: const ProfileDrawer(),
      appBar: AppBar(
        backgroundColor: ConfigColor.primaryColor,
        actions: [
          Container(
            alignment: Alignment.center,
            child: SearchBarAnimation(
                searchEditingController: searchEditingController,
                appBarTitle: ConfigText.appName),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height * 1.5));
                  },
                  blendMode: BlendMode.dstIn,
                  child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.50,
                      child: ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                        child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 5, sigmaY: 6),
                            child: musicImage),
                      )),
                ),
                Container(
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 18.0),
                        blurRadius: 10.0)
                  ]),
                  height: MediaQuery.sizeOf(context).height * 0.36,
                  width: MediaQuery.sizeOf(context).width * 0.78,
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15.0)),
                      child: Hero(tag: 'Song Image${widget.songDetails?[2]}',
                          child: musicImage)),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.songDetails != null &&
                            widget.songDetails![0].length > 20)
                          SizedBox(
                            height: 30,
                            child: songTitleAnimation(
                                widget.songDetails?[0] ?? 'City Boy'),
                          )
                        else
                          Text(
                            widget.songDetails?[0] ?? 'City Boy',
                            style: GoogleFonts.ubuntu(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: ConfigColor.secondaryColor,
                            ),
                          ),
                        Text(
                          widget.songDetails?[1] ?? 'Burna Boy',
                          style: GoogleFonts.ubuntu(
                              fontSize: 18,
                              color: ConfigColor.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.star,
                          size: 25,
                          color: ConfigColor.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz,
                          size: 25,
                          color: ConfigColor.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Slider(
              thumbColor: ConfigColor.white,
              activeColor: ConfigColor.white,
              inactiveColor: ConfigColor.deepPrimaryColor,
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              allowedInteraction: SliderInteraction.slideThumb,
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                // Optional: Play audio if was paused
                await audioPlayer.resume();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatTime(position),
                    style: GoogleFonts.ubuntu(
                        color: ConfigColor.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.5),
                  ),
                  Text(
                    formatTime(duration - position),
                    style: GoogleFonts.ubuntu(
                        color: ConfigColor.secondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.5),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 75.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.fast_rewind_rounded,
                    ),
                    iconSize: 50,
                    color: ConfigColor.white,
                    onPressed: () async {
                      previousSong();
                    },
                  ),
                  Stack(
                    children: [
                      Positioned.fill(
                        child: isPlaying
                            ? RippleAnimation(
                                size: const Size(5, 5),
                                repeat: true,
                                color: ConfigColor.white,
                                minRadius: 30,
                                ripplesCount: 8,
                                child: const SizedBox(),
                              )
                            : const SizedBox(),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 35,
                        child: playPauseButton(),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.fast_forward_rounded),
                    iconSize: 50,
                    color: ConfigColor.white,
                    onPressed: () async {
                      nextSong();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  IconButton playPauseButton() {
    return IconButton(
      icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow_rounded),
      iconSize: 55,
      color: ConfigColor.primaryColor,
      onPressed: () async {
        if (isPlaying) {
          await audioPlayer.pause();

        } else {
          setAudio();
          await audioPlayer.resume();
        }
      },
    );
  }
}
