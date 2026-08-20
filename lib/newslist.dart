import 'package:flutter/material.dart';
import 'package:vtek/parser.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});
  @override
  State<StatefulWidget> createState() => _NewsListState();

}


class _NewsListState extends State<NewsList> {
  List<Map<String, String>> news = [];
  @override
  void initState() {
    fetchNewsList('https://t130631.spo.obrazovanie33.ru').then((value) => setState(() {
      news = value;
    }));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget newsWidget = ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index){
          return ListTile(
              title: Text(news[index]['title'] ?? ''),
              leading: SizedBox(
                width: 80,
                height: 60,
                child: Image.network(news[index]['img_url'] ?? ''),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/news', arguments: news[index]['url']);
          },
          );
        }
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новости'),
      ),
        body: newsWidget,
    );




  }

}