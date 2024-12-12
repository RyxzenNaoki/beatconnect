import 'package:flutter/material.dart';
import 'package:beatconnect/view/get_started/get_started_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotify',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const GetStartedPage(),
    );
  }
}
