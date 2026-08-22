import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vtek/parser.dart';

import 'menu.dart';

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
    if (news.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget newsWidget = ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index){
          return Container(
            margin: const EdgeInsets.all(3),
            child: ListTile(
              title: Text(
                news[index]['title'] ?? '',
              ),
              leading: SizedBox(
                width: 80,
                height: 60,
                child: CachedNetworkImage(imageUrl: news[index]['img_url'] ?? ''),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/news', arguments: news[index]['url']);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.black54,
                  width: 2,
                ),
              ),
            ),
          );
        }
    );
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: const Text('Новости'),
      ),
        body: newsWidget,
    );
  }

}