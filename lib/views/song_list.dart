import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/configs/config_text.dart';
import 'package:freemusic/models/audio_provider.dart';
import 'package:freemusic/models/songlist.dart';
import 'package:freemusic/views/home.dart';
import 'package:freemusic/widgets/searchBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class SongList extends StatefulWidget {
  const SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  TextEditingController searchEditingController = TextEditingController();

  SongLists songLists = SongLists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: ConfigColor.primaryColor,
        actions: [
          Container(
            alignment: Alignment.center,
            child: SearchBarAnimation(
                searchEditingController: searchEditingController,
                appBarTitle: ConfigText.allSongAppBarTitle),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: context.read<AudioProvider>().songLists.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(
                          songDetails: context.read<AudioProvider>().songLists[index],
                        ),
                      ), ModalRoute.withName('/'),);
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Hero(
                        tag: 'Song Image${context.read<AudioProvider>().songLists[index][2]}',
                        child: Image.network(context.read<AudioProvider>().songLists[index][2])),
                  ),
                  title: Text(
                    context.read<AudioProvider>().songLists[index][0],
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(
                    Icons.play_circle_fill,
                    color: ConfigColor.primaryColor,
                    size: 26,
                  ),
                  subtitle: Text(
                    context.read<AudioProvider>().songLists[index][1],
                    style: GoogleFonts.ubuntu(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
