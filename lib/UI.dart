import 'package:flutter/material.dart';
import 'package:vtek/parser.dart';

import 'simplepage.dart';
import 'newslist.dart';
import 'newspage.dart';

final Parser parser = Parser('https://t130631.spo.obrazovanie33.ru');
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
        '/enroll': (context) => SimplePage(parserdata: parser.fetchHowToEnroll('https://t130631.spo.obrazovanie33.ru/postuplenie/'),
                                          pageTitle: 'Как поступить',),
        '/contacts': (context) => SimplePage(parserdata: parser.fetchContacts('https://t130631.spo.obrazovanie33.ru/'),
                                          pageTitle: 'Контакты',),
      },
      title: 'VTEK',
    );
  }
}