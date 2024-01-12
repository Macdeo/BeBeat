import 'package:flutter/material.dart';
import 'package:freemusic/configs/config_color.dart';
import 'package:freemusic/configs/config_text.dart';
import 'package:freemusic/widgets/searchBar.dart';
import 'package:google_fonts/google_fonts.dart';

class Artist extends StatelessWidget {
  TextEditingController searchEditingController = TextEditingController();
  final List<List<String>> artistData = [
    ['https://leadership.ng/wp-content/uploads/2023/03/burna.png', 'Burna Boy'],
    [
      'https://dailytrust.com/wp-content/uploads/2022/02/Adekunle-Gold.jpeg',
      'Adekunle Gold'
    ],
    [
      'https://ichef.bbci.co.uk/news/640/cpsprodpb/a1e6/live/8818d4d0-51a0-11ee-a312-b99ac17e5cba.jpg',
      'Mohbad'
    ],
    [
      'https://leadership.ng/wp-content/uploads/2023/09/IMG-20230917-WA0004.jpg',
      'Bella Shmudra'
    ],
    [
      'https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F41a2067e-6b0a-4efc-8c7b-a0efe640c51c_1080x1350.jpeg',
      'Omah Lay'
    ],
    [
      'https://media.licdn.com/dms/image/D4E12AQEoMyUC-FL4Ng/article-inline_image-shrink_1500_2232/0/1686338744040?e=1709769600&v=beta&t=TJL5QW4dgYP_c8NXX60fPbgFMqKHqRPpbPgfwWM6Vws',
      'Odumodu Blvck'
    ],
    [
      'https://resources.tidal.com/images/03b511ce/d506/4614/bad0/90989f341402/750x750.jpg',
      'Buju Bnxn'
    ],
    [
      'https://static.news.bitcoin.com/wp-content/uploads/2021/02/uUxDba0v-davido.jpg',
      'Davido'
    ],
    [
      'https://www.billboard.com/wp-content/uploads/2023/06/Asake-cr-Ola-Alabi-billboard-1548.jpg?w=942&h=623&crop=1',
      'Asake'
    ],[
      'https://www.clashmusic.com/wp-content/uploads/2023/10/Ruger-2.jpeg',
      'Ruger'
    ],
  ];

  Artist({super.key});

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
                  appBarTitle: ConfigText.allArtistAppBarTitle),
            ),
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 20),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const Column(
                  children: [
                    SizedBox(height: 5,),
                     Divider(),
                    SizedBox(height: 5,),
                  ],
                );
              },
              itemCount: artistData.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      backgroundColor: ConfigColor.white,
                      backgroundImage: NetworkImage(
                          artistData[index][0]),
                    ),
                    title: Text(
                      artistData[index][1],
                      style: GoogleFonts.ubuntu(fontWeight: FontWeight.w400),
                    ),
                  ),
                );
              }),
        ));
  }
}
