
import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/configs/config_text.dart';

class SearchBarAnimation extends StatelessWidget {
  const SearchBarAnimation({
    super.key,
    required this.searchEditingController,
    required this.appBarTitle,
  });

  final TextEditingController searchEditingController;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return AnimationSearchBar(
        cursorColor: ConfigColor.white,
        isBackButtonVisible: false,
        searchIconColor: ConfigColor.white,
        closeIconColor: ConfigColor.white,
        backIconColor: Colors.white,
        centerTitle: appBarTitle,
        centerTitleStyle: const TextStyle(
            color: ConfigColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        onChanged: (text) => debugPrint(text),
        searchTextEditingController: searchEditingController,
        textStyle: const TextStyle(color: ConfigColor.white),
        hintText: ConfigText.searchHintText,
        hintStyle: const TextStyle(
            color: ConfigColor.white, fontWeight: FontWeight.w500),
        horizontalPadding: 25);
  }
}