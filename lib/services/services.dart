import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prestation/constants/service.dart';
import 'package:prestation/interfaces/service.dart';
import 'package:prestation/models/user.dart';
import 'package:prestation/utils/auth.dart';

class Service<T extends IService<T>> {
  final String path;
  final T instance;
  Service(this.instance, this.path);

  Future<List<T>> list() async {
    final http.Client client = http.Client();
    var response = await client.get(Uri.https(baseUrl, path));
    List<T> list = instance.fromJsonList(json.decode(response.body));
    client.close();
    return list;
  }

  Future<T> create(Map<String, dynamic> map) async {
    final http.Client client = http.Client();
    var data = json.encode(map);
    var response = await client.post(Uri.https(baseUrl, path),
        body: data, headers: jsonHeaders);
    var body = json.decode(response.body);
    client.close();
    instance.fromJson(body);
    return instance;
  }

  Future<bool> register(Map<String, dynamic> map) async {
    final http.Client client = http.Client();
    var response =
        await client.post(Uri.https(baseUrl, "$path/register"), body: map);
    var body = json.decode(response.body);
    client.close();
    if (response.statusCode == 200) {
      instance.fromJson(body);
      return true;
    }
    return false;
  }

  Future<T> edit(String id, Map<String, dynamic> map) async {
    final http.Client client = http.Client();
    var data = json.encode(map);
    var response = await client.put(Uri.https(baseUrl, '$path/$id'),
        body: data, headers: jsonHeaders);
    var body = json.decode(response.body);
    client.close();
    instance.fromJson(body);
    return instance;
  }

  Future<bool> delete(String id) async {
    final http.Client client = http.Client();
    var response = await client.delete(Uri.https(baseUrl, "$path/$id"));
    client.close();
    return response.statusCode == 200;
  }

  static Future<bool> login(String email, String password) async {
    Map<String, String> map = {"email": email, "password": password};
    var data = json.encode(map);
    final http.Client client = http.Client();
    var response = await client.post(Uri.https(baseUrl, "$urlUser/token"),
        body: data, headers: jsonHeaders);
    var logged = false;
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      addToken(body['access_token']);
      logged = true;
    }
    client.close();
    return logged;
  }

  Future<User> me() async {
    final http.Client client = http.Client();
    var response = await client.get(Uri.https(baseUrl, "$urlUser/me"),
        headers: authHeaderJson);
    var body = json.decode(response.body);
    var user = User.getInstance(body);
    client.close();
    return user;
  }
}
