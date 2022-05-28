import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class User {
  int id;
  String username;

  User({required this.id, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], username: json['username']);
  }
  
  @override
  String toString() {
    return '$username $id';
  }
}

Future<User> fetchUser(int userId) async {
  var res = await http.get(Uri.https('jsonplaceholder.typicode.com', '/users/$userId'));
  if (res.statusCode == HttpStatus.ok) {
    return User.fromJson(jsonDecode(res.body));
  }
  throw Exception('Cannot fetch user with id $userId');
}

void useUser(int userId) async {
  try {
    var user = await fetchUser(userId);
    print(user);
  } catch (e) {
    print(e); 
  }
}

void main(List<String> arguments) {
  if (arguments.isEmpty) throw Exception('lol');
  useUser(int.parse(arguments[0]));
}
