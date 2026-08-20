import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

Future<List<Map<String, String>>> fetchNewsList(String url) async {
  final response = await http.get(Uri.parse(url + '/news/'));
  final document = parser.parse(response.body);
  final elements = document.querySelectorAll('div.events-card');
  List<Map<String, String>> news = [];
  for(Element el in elements){
    String title = el.querySelector('h3')?.text ?? '';
    String news_url = url + el.querySelector('h3')!.querySelector('a')!.attributes['href']! ?? '';
    String img_url = url + el.querySelector('div.events-card__image')!.querySelector('img')!.attributes['src']! ?? '';
    news.add({
      'title': title,
      'url': news_url,
      'img_url': img_url
    });
  }
  return news;
}

Future<Map<String, dynamic>> fetchOneNews(String newsUrl, String siteUrl) async{
  final response = await http.get(Uri.parse(newsUrl));
  final document = parser.parse(response.body);
  Map<String, dynamic> news = {};
  news['img_urls'] = [];
  news['title'] = document.querySelector('h1')?.text ?? '';
  final imgDivs = document.querySelectorAll('div.newsdetail-slide') ?? [];
  for (Element imgDiv in imgDivs) {
   String img_url = siteUrl + imgDiv.querySelector('img')!.attributes['src']! ?? '';
   news['img_urls'].add(img_url);
  }
  var newsElement = document.querySelector('section.newsdetail-section');
  var imagesToRemove = newsElement?.querySelector('div.newsdetail-block');
  imagesToRemove?.remove();
  news['content'] = newsElement?.innerHtml ?? '';
  return news;
}