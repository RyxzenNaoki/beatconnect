import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/model.dart'; // Import your model here

class Artist extends StatefulWidget {
  const Artist({
    Key? key,
  }) : super(key: key);

  @override
  _ArtistState createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  final apiService = ApiService();
  List<ArtistModel> artists = []; // Use ArtistModel list instead of dynamic

  @override
  void initState() {
    super.initState();
    fetchArtistsData();
  }

  Future<void> fetchArtistsData() async {
    try {
      final List<ArtistModel>? artistsData = await apiService.getArtists();
      if (artistsData != null) {
        setState(() {
          artists = artistsData;
        });
      } else {
        throw Exception('No data received from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: artists.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          final artist = artists[index]; // Now it's an ArtistModel object

          return Container(
            width: 155,
            padding:
                const EdgeInsets.only(right: 15, left: 15, top: 15, bottom: 0),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: ColorConstants.cardBackGroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: 125,
                    width: 125,
                    child: Image.asset(
                        artist.image)), // Using 'image' from ArtistModel
                const SizedBox(
                  height: 16,
                ),
                Text(artist.name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)) // Using 'name' from ArtistModel
              ],
            ),
          );
        },
      ),
    );
  }
}
