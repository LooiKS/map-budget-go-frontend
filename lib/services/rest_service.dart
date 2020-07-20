import 'dart:convert';
import 'package:http/http.dart' as http;

// RestService is a wrapper class implmenting for REST API calls.
//  The class is implemented using the Singleton design pattern.
//  i.e. this class will only be instantiated once

class RestService {
  //------- Here is how we implement 'Singleton pattern' in Dart --------
  static final RestService _instance = RestService._constructor();
  factory RestService() {
    return _instance;
  }

  RestService._constructor();
  //---------------------------- end of singleton implementation

  // TODO: change the baseUrl to your own REST API service hosted on Firebase (or heroku)

  static const String baseUrl =
      'http://10.0.2.2:5001/map-budget-go/us-central1/api';
  // 'https://us-central1-map-budget-go.cloudfunctions.net/api';

  Future get(String endpoint) async {
    final response = await http.get('$baseUrl/$endpoint');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future post(String endpoint, {dynamic data}) async {
    final response = await http.post('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future postPhoto(String endpoint, {dynamic data}) async {
    var request = http.MultipartRequest(
      "POST",
      Uri.parse('$baseUrl/$endpoint'),
    );
    request.files.add(http.MultipartFile.fromBytes('avatar', data));

    final response = await request.send();

    if (response.statusCode == 200) {
      return {"status": "ok"};
    }
    throw response;
  }

  Future patch(String endpoint, {dynamic data}) async {
    print(data);
    final response = await http.patch('$baseUrl/$endpoint',
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future delete(String endpoint) async {
    final response = await http.delete('$baseUrl/$endpoint');

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }
}
