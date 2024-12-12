import 'package:flutter/material.dart';
import 'package:beatconnect/view/tab/more/widget/activity_card.dart';
import 'package:beatconnect/view/tab/more/widget/more_title.dart';
import 'package:beatconnect/view/tab/more/widget/play_list_card.dart';
import 'package:beatconnect/view/tab/widgets/custom_title.dart';
import 'addsong.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 54,
            ),
            const MoreTitle(title: 'Your Library'),
            const PlayListCard(),
            Align(
              alignment: Alignment.center,
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const CustomTitle(title: 'Your Activities'),
            const SizedBox(
              height: 16,
            ),
            ActivityCard(
              title: 'Add Songs',
              icon: Icons.favorite,
              onTap: () {
                // Aksi untuk ActivityCard "Liked Songs"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSongPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
