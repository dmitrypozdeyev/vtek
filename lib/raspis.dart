import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view_gallery.dart';

import 'menu.dart';

class Rasps  extends StatefulWidget{
  final int initialIndex;
  const Rasps({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<Rasps> createState() => _RaspsState();

}

class _RaspsState extends State<Rasps>{
  List<String> imgFiles = [];
  Widget result = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState(){
    super.initState();
    http.get(Uri.parse('https://schedule.vztec.ru/rasp/files.json')).then((resp){
      List<dynamic> files = jsonDecode(resp.body);
      setState(() {
        imgFiles = files.map((f) => 'https://schedule.vztec.ru/rasp/$f').toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (imgFiles.isNotEmpty) {
      result = PhotoViewGallery.builder(
        itemCount: imgFiles.length,
        pageController: PageController(
          initialPage: widget.initialIndex,
        ),
        builder: (context, i) {
          return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(imgFiles[i]),
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image),
              )
          );
        },
        backgroundDecoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      );

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Расписание'),
      ),
      drawer: MainDrawer(),
      body: result,
    );
  }
}
