import 'package:flutter/material.dart';
import 'package:vtek/parser.dart';
import 'package:vtek/raspis.dart';

import 'main.dart';
import 'simplepage.dart';
import 'newslist.dart';
import 'newspage.dart';

final Parser parser = Parser('https://t130631.spo.obrazovanie33.ru');
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NewsList(),
        '/news': (context) => const NewsPage(),
        '/enroll': (context) => SimplePage(parserdata: parser.fetchHowToEnroll('https://t130631.spo.obrazovanie33.ru/postuplenie/'),
                                          pageTitle: 'Как поступить',),
        '/contacts': (context) => SimplePage(parserdata: parser.fetchContacts('https://t130631.spo.obrazovanie33.ru/'),
                                          pageTitle: 'Контакты',),
        '/rasp': (context) => Rasps(),
      },
      title: 'VTEK',
    );
  }
}