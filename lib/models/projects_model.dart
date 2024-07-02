import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> create_project(String name, int duree, String description) async {
  final response = await http.post(Uri.parse("http://10.0.2.2/:8000/api/creer_projet"),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ',
    },
    body: jsonEncode({
      'name': name,
      'duree': duree,
      'description': description,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    print('Failed to create project: ${response.body}');
    return false;
  }

}