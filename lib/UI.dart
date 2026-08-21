import 'package:flutter/material.dart';

import 'enroll.dart';
import 'newslist.dart';
import 'newspage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const NewsList(),
        '/news': (context) => const NewsPage(),
        '/enroll': (context) => const Enroll(),
      },
      title: 'VTEK',
    );
  }
}