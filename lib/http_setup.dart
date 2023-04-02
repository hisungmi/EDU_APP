import 'package:http/http.dart' as http;

const String baseUrl = "http://52.78.111.175:8000"; // 기본 url (고정)
final http.Client httpClient = http.Client(); // 아 이거 뭐더라 까먹었어요

Map<String, String> getHeaders() {
  // 헤더 설정
  return {
    'Content-Type': 'application/json',
  };
}

Future<http.Response> post(String url, String body) async {
  // post 메소드
  final headers = getHeaders();
  final response = await httpClient.post(Uri.parse('$baseUrl$url'),
      headers: headers, body: body);
  return response;
}
