import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:vtek/parser.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map<String, dynamic> news = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final url = ModalRoute.of(context)!.settings.arguments as String;


    fetchOneNews(
      url,
      'https://t130631.spo.obrazovanie33.ru',
    ).then((value) {
      setState(() {
        news = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Widget newsText = SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Html(
          data: news['content'] ?? '',
        )
    );
    Widget images = ListView.builder(itemBuilder: (contex, index) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Image.network(news['img_urls'][index]),
      );
    },
      itemCount: news['img_urls'].length,
      scrollDirection: Axis.horizontal,);
    return Scaffold(
      appBar: AppBar(
        title: Text(news['title'] ?? ''),
      ),
      body: Column(
        children: [
          Expanded(child: newsText),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: images,
          ),
        ]
      )
    );
  }
}