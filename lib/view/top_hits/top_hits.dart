import 'package:beatconnect/koneksi.dart';
import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
import 'package:beatconnect/view/top_hits/widgets/sliver_app_bar_widget.dart';

import 'package:beatconnect/model.dart'; // Import the TopHitModel here

class TopHits extends StatefulWidget {
  const TopHits({super.key});

  @override
  State<TopHits> createState() => _TopHitsState();
}

class _TopHitsState extends State<TopHits> {
  final ApiService apiService = ApiService();
  List<TopHitModel> topHit = []; // Use the TopHitModel class

  @override
  void initState() {
    super.initState();
    fetchTopHitsData();
  }

  Future<void> fetchTopHitsData() async {
    try {
      final List<TopHitModel>? topHitsData = await apiService.getTopHits();

      // Periksa apakah data berhasil diterima
      if (topHitsData != null) {
        setState(() {
          topHit = topHitsData; // Asumsikan topHit adalah List<TopHitModel>
        });
      } else {
        throw Exception('Failed to fetch top hits data or no data found');
      }
    } catch (e) {
      // Tangani error
      print('Error fetching top hits data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          const SliverAppBarWidget(),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: ColorConstants.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 35,
                  ),
                ),
                const Text('Featured',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal)),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 5,
                      thickness: 0.5,
                      color: Colors.grey,
                    );
                  },
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: topHit.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = topHit[index]; // Now using TopHitModel

                    return Card(
                      color: Colors.black,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                      item.image), // Access image via model
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)),
                                    const SizedBox(height: 8),
                                    Text(item.description,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite,
                                    color: item.favorite
                                        ? ColorConstants.primaryColor
                                        : Colors.white),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
