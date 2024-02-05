import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/models/audio_provider.dart';
import 'package:freemusic/models/songlist.dart';
import 'package:provider/provider.dart';

import 'controllers/homeController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AudioProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BeBeat',
        theme: ThemeData(
          primaryColor: ConfigColor.primaryColor,
        ),
        home: const HomeController(),
      ),
    );
  }
}
