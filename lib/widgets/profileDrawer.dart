

import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/views/artists.dart';
import 'package:freemusic/views/song_list.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            curve: Curves.linear,
            decoration: const BoxDecoration(
              color: ConfigColor.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: ConfigColor.white,
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Robert Newton',
                  style: GoogleFonts.ubuntu(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ConfigColor.white),
                ),
              ],
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              'Library',
              style: GoogleFonts.ubuntu(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.queue_music,
                color: ConfigColor.primaryColor, size: 30),
            title: Text(
              'Playlists',
              style: GoogleFonts.ubuntu(fontSize: 17),
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.mic_external_on,
                color: ConfigColor.primaryColor, size: 30),
            title:  Text('Artists', style: GoogleFonts.ubuntu(fontSize: 17)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Artist()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_music,
                color: ConfigColor.primaryColor, size: 30),
            title: Text('Songs', style: GoogleFonts.ubuntu(fontSize: 17)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SongList()));
            },
          ),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Divider(
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ListTile(
            leading: const Icon(Icons.person,
                color: ConfigColor.primaryColor, size: 30),
            title: Text('Account', style: GoogleFonts.ubuntu(fontSize: 17)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings,
                color: ConfigColor.primaryColor, size: 30),
            title: Text('Settings', style: GoogleFonts.ubuntu(fontSize: 17)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout,
                color: ConfigColor.primaryColor, size: 30),
            title: Text('Log Out', style: GoogleFonts.ubuntu(fontSize: 17, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
