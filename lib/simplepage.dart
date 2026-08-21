import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'menu.dart';

class SimplePage extends StatefulWidget{
  final Future<String> parserdata;
  final String pageTitle;
  const SimplePage({
    super.key,
    required this.parserdata,
    required this.pageTitle,
  });

  @override
  State<SimplePage> createState() => _SimplePageState();

}

class _SimplePageState extends State<SimplePage> {
  String content = '';
  Widget contentWidget = Center(
    child: CircularProgressIndicator(),
  );


  @override
  void initState() {
    super.initState();
    widget.parserdata.then(
      (value) => setState(() {
        content = value;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    if (content.isNotEmpty) {
      contentWidget = SingleChildScrollView(
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      drawer: const MainDrawer(),
      body: contentWidget,
    );
  }
}
