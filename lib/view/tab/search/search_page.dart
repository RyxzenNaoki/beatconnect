import 'package:flutter/material.dart';
import 'package:beatconnect/constants/colors.dart';
import 'package:beatconnect/view/tab/search/widget/browse_card.dart';
import 'package:beatconnect/view/tab/search/widget/podcast.dart';
import 'package:beatconnect/view/tab/search/widget/search_input.dart';
import 'package:beatconnect/view/tab/widgets/custom_title.dart';
import 'package:beatconnect/view/tab/widgets/welcome_title.dart';
import 'package:beatconnect/koneksi.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final apiService = ApiService();
  List<String> searchList = [];

  @override
  void initState() {
    super.initState();
    fetchSearchListData();
  }

  Future<void> fetchSearchListData() async {
  try {
    // Panggil metode getSearchList dari ApiService
    final List<String>? searchListData = await apiService.getSearchList();

    // Periksa apakah data tidak null
    if (searchListData != null) {
      setState(() {
        searchList = searchListData; // Perbarui state dengan data yang diterima
      });
    } else {
      throw Exception('No data received from API');
    }
  } catch (e) {
    // Tangani error
    print('Error fetching search list data: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 54,
              ),
              const WelcomeTitle(title: 'Search'),
              const SizedBox(
                height: 32,
              ),
              const SearchInput(),
              const SizedBox(
                height: 13,
              ),
              Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: searchList
                      .map(
                        (search) => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: ColorConstants.cardBackGroundColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              search,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            )),
                      )
                      .toList()),
              const SizedBox(
                height: 24,
              ),
              const CustomTitle(title: 'Podcast’s'),
              const SizedBox(
                height: 13,
              ),
              const PodCast(),
              const SizedBox(
                height: 12,
              ),
              const CustomTitle(title: 'Browse all'),
              const SizedBox(
                height: 13,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  BrowseCard(
                      title: 'Made For You',
                      color1: '#E02FCF',
                      color2: '#00C188'),
                  BrowseCard(
                      title: 'Charts', color1: '#0A3CEC', color2: '#4DD4AC'),
                  BrowseCard(
                      title: 'Discover', color1: '#0A3CEC', color2: '#D9DD01'),
                  BrowseCard(
                      title: 'New Release',
                      color1: '#0E31AE',
                      color2: '#DD1010'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
