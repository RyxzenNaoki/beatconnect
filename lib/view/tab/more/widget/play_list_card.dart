import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/model.dart';

class PlayListCard extends StatefulWidget {
  const PlayListCard({
    Key? key,
  }) : super(key: key);

  @override
  _PlayListCardState createState() => _PlayListCardState();
}

class _PlayListCardState extends State<PlayListCard> {
  final apiService = ApiService();
  List<dynamic> playList = [];

  @override
  void initState() {
    super.initState();
    fetchPlayListData();
  }

  Future<void> fetchPlayListData() async {
    try {
      final List<PlaylistModel>? playListData = await apiService.getPlaylists();
      if (playListData != null) {
        setState(() {
          playList = playListData;
        });
      } else {
        throw Exception('Failed to fetch playlist data or no data found');
      }
    } catch (e) {
      print('Error fetching playlist data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: playList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, int index) {
        final play = playList[index];

        return Container(
          decoration: BoxDecoration(
              color: ColorConstants.cardBackGroundColor,
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(
            top: 10,
          ),
          margin: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  PlayListImage(image: play.image1),
                  PlayListImage(image: play.image2),
                  PlayListImage(image: play.image3),
                  PlayListImage(image: play.image4),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(play.title,
                  style: TextStyle(
                    color: ColorConstants.starterWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          ),
        );
      },
    );
  }
}

class PlayListImage extends StatelessWidget {
  const PlayListImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      width: 75,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
    );
  }
}
