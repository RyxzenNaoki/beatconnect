import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'package:beatconnect/view/top_hits/top_hits.dart';
import 'package:beatconnect/model.dart';
import 'package:beatconnect/koneksi.dart'; // Import your model here

class TopMusic extends StatefulWidget {
  const TopMusic({
    Key? key,
  }) : super(key: key);

  @override
  _TopMusicState createState() => _TopMusicState();
}

class _TopMusicState extends State<TopMusic> {
  final apiService = ApiService();
  List<TopMixModel> topMixes = []; // Use TopMixModel list instead of dynamic

  @override
  void initState() {
    super.initState();
    fetchTopMixesData();
  }

  Future<void> fetchTopMixesData() async {
    try {
      final List<TopMixModel>? topMixesData = await apiService.getTopMixes();

      // Jika data berhasil diambil, perbarui state
      if (topMixesData != null) {
        setState(() {
          topMixes = topMixesData; // Perbarui variabel topMixes
        });
      } else {
        throw Exception('Failed to fetch top mixes data or no data found');
      }
    } catch (e) {
      // Tangani error
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: topMixes.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          final topMix = topMixes[index]; // Now it's a TopMixModel object

          return GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TopHits())),
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.cardBackGroundColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 15, bottom: 0),
              margin: const EdgeInsets.all(4),
              width: 160,
              height: 195,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 113,
                    width: 125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                                topMix.image), // Using 'image' from TopMixModel
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 7,
                          height: 24,
                          decoration: BoxDecoration(
                              color: hexToColor(topMix
                                  .color)), // Using 'color' from TopMixModel
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                              color: hexToColor(topMix.color),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(topMix.title, // Using 'title' from TopMixModel
                      style: TextStyle(
                        color: ColorConstants.starterWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                      topMix
                          .description, // Using 'description' from TopMixModel
                      style: TextStyle(
                        color: ColorConstants.starterWhite,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
