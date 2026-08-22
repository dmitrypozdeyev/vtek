import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:vtek/parser.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map<String, dynamic> news = {};
  Widget result = Scaffold();

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
          onLinkTap: (url, attributes, element) async{
            if (url?.startsWith('http') ?? false) {
              await launchUrl(
                Uri.parse(url!),
                mode: LaunchMode.externalApplication,
              );
            }
          },
        )
    );
    Widget images = ListView.builder(itemBuilder: (contex, index) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          onTap: () => showPhoto(index),
          child: CachedNetworkImage(imageUrl: news['img_urls'][index],),
        ),
      );
    },
      itemCount: news['img_urls'].length,
      scrollDirection: Axis.horizontal,);
    if (news['img_urls'].length == 0) {
      result = Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(
            title: Text(news['title'] ?? ''),
          ),
          body: newsText,
      );
    }
    else {
      result = Scaffold(
          drawer: MainDrawer(),
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
    return result;
  }

  Future<void> showPhoto(index) async {
    List<String> images = List<String>.from(news['img_urls']);
    showDialog(context: context,
        builder: (context){
      return Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, i) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(images[i]),
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image),
              )
            );
          },
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        )
      );
    });
  }
}