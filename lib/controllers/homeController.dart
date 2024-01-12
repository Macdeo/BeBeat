import 'dart:async';


import 'package:flutter/material.dart';
import 'package:freemusic/views/home.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});


  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
