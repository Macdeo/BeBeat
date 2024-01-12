import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';

import 'controllers/homeController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeBeat',
      theme: ThemeData(
        primaryColor: ConfigColor.primaryColor,
      ),
      home: const HomeController(),
    );
  }
}
