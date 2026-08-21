import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtek/parser.dart';

import 'menu.dart';

class Enroll extends StatefulWidget{

  const Enroll({super.key});

  @override
  State<Enroll> createState() => _EnrollState();

}

class _EnrollState extends State<Enroll> {
  String content = '';

  @override
  void initState() {
    super.initState();
    fetchHowToEnroll('https://t130631.spo.obrazovanie33.ru/postuplenie/', 'https://t130631.spo.obrazovanie33.ru').then(
      (value) => setState(() {
        content = value;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Как Поступить'),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsetsGeometry.all(16),
        child: Html(
          data: content,
          onLinkTap: (url, attributes, element) async{
            if (url?.startsWith('http') ?? false) {
              await launchUrl(
                Uri.parse(url!),
                mode: LaunchMode.externalApplication,
              );
            }
          },
        ),
      ),
    );
  }
}
