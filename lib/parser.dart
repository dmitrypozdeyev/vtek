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
    String newsUrl = url + el.querySelector('h3')!.querySelector('a')!.attributes['href']!;
    String imgUrl = url + el.querySelector('div.events-card__image img')!.attributes['src']!;
    news.add({
      'title': title,
      'url': newsUrl,
      'img_url': imgUrl
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
  final imgDivs = document.querySelectorAll('div.newsdetail-slide');
  for (Element imgDiv in imgDivs) {
   String img_url = siteUrl + imgDiv.querySelector('img')!.attributes['src']!;
   news['img_urls'].add(img_url);
  }
  var newsElement = document.querySelector('section.newsdetail-section');
  var imagesToRemove = newsElement?.querySelector('div.newsdetail-block');
  imagesToRemove?.remove();
  newsElement?.querySelector('img')?.attributes['src']=siteUrl + newsElement.querySelector('img')!.attributes['src']!;
  news['content'] = newsElement?.innerHtml ?? '';
  return news;
}

Future<String> fetchHowToEnroll(String url, String siteUrl) async{
  final response = await http.get(Uri.parse(url));
  final document = parser.parse(response.body);
  final material = document.querySelector('h1')?.parent;
  final title = material?.querySelector('h1');
  title?.remove();
  final List<Element> imgs = material?.querySelectorAll('img') ?? [];
  for (var img in imgs){
    img.attributes['src'] = siteUrl + img.attributes['src']!;
  }
  List<Element> links = material?.querySelectorAll('a') ?? [];
  for (var link in links){
    if (!(link.attributes['href']!.startsWith('http'))) link.attributes['href'] = siteUrl + link.attributes['href']!;
  }
  final content = material?.innerHtml;
  print(content);
  return content ?? '';
}

Future<String> fetchContacts(String url, String siteUrl) async{
  final response = await http.get(Uri.parse(url));
  final document = parser.parse(response.body);
  final contacts = document.querySelector('div.footer-nav__contacts');
  final imgs = contacts?.querySelectorAll('img');
  if (imgs != null) {
    for (Element img in imgs) {
      img.attributes['src'] = siteUrl + img.attributes['src']!;
    }
  }
  return contacts!.innerHtml;
}