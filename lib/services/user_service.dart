import 'dart:convert';

import 'package:fetch_api_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _baseUrl = 'https://dummyjson.com';

  Future<List<User>> getUser(int limit, int skip) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/users?limit=$limit&skip=$skip'));

    final data = json.decode(response.body)['users'];
    return List<User>.from(data.map((val) => User.fromJson(val)));
  }
}
