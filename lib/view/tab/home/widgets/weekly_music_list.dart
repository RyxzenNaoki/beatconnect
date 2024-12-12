import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/model.dart'; // Make sure to import your SliderModel here

class WeeklyMusicList extends StatefulWidget {
  const WeeklyMusicList({
    Key? key,
  }) : super(key: key);

  @override
  _WeeklyMusicListState createState() => _WeeklyMusicListState();
}

class _WeeklyMusicListState extends State<WeeklyMusicList> {
  final apiService = ApiService();
  List<SliderModel> slider = []; // Use SliderModel list instead of dynamic

  @override
  void initState() {
    super.initState();
    fetchSliderData();
  }

  Future<void> fetchSliderData() async {
    try {
      final List<SliderModel>? SlidersData = await apiService.getSliders();
      if (SlidersData != null) {
        setState(() {
          slider = SlidersData; // Use fromJsonList method
        });
      } else {
        throw Exception('Failed to fetch slider data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: slider.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          final slid = slider[index]; // Now it's a SliderModel object

          return Column(
            children: [
              Container(
                height: 125,
                width: 240,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image:
                        AssetImage(slid.image), // Access image from SliderModel
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(slid.title, // Access title from SliderModel
                  style: TextStyle(
                    color: ColorConstants.starterWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          );
        },
      ),
    );
  }
}
