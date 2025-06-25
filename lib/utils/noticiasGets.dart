import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

Future<RssFeed> getNews() async {
  var response = await http.get(Uri.parse("https://www.elcomercio.com/feed/"));
  return RssFeed.parse(response.body);
}