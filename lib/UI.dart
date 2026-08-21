import 'package:flutter/material.dart';
import 'package:vtek/parser.dart';

import 'simplepage.dart';
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
        '/enroll': (context) => SimplePage(parserdata: fetchHowToEnroll('https://t130631.spo.obrazovanie33.ru/postuplenie/',
            'https://t130631.spo.obrazovanie33.ru'),
                                          pageTitle: 'Как поступить',),
        '/contacts': (context) => SimplePage(parserdata: fetchContacts('https://t130631.spo.obrazovanie33.ru/',
            'https://t130631.spo.obrazovanie33.ru/'),
                                          pageTitle: 'Контакты',),
      },
      title: 'VTEK',
    );
  }
}