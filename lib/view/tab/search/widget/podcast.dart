import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/model.dart';

class PodCast extends StatefulWidget {
  const PodCast({
    Key? key,
  }) : super(key: key);

  @override
  _PodCastState createState() => _PodCastState();
}

class _PodCastState extends State<PodCast> {
  final ApiService apiService = ApiService();
  List<dynamic> podCast = [];

  @override
  void initState() {
    super.initState();
    fetchPodCastData();
  }

  Future<void> fetchPodCastData() async {
    try {
      final List<PodcastModel>? podCastData = await apiService.getPodcasts();
      if (podCastData != null) {
        setState(() {
          podCast = podCastData;
        });
      } else {
        throw Exception('Failed to fetch podcast data or no data found');
      }
    } catch (e) {
      print('Error fetching podcast data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: podCast.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            final podcast = podCast[index];

            return Container(
              decoration: BoxDecoration(
                  color: ColorConstants.cardBackGroundColor,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 15, bottom: 0),
              margin: const EdgeInsets.all(4),
              width: 155,
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
                            image: AssetImage(podcast.image),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(podcast.title,
                      style: TextStyle(
                        color: ColorConstants.starterWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(podcast.description,
                      style: TextStyle(
                        color: ColorConstants.starterWhite,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
            );
          }),
    );
  }
}
