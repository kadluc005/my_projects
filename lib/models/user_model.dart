import 'dart:convert';

import 'package:http/http.dart' as http;

String? token;
Future<bool> register(String name, String email, String phone, String password, String confirmPassword) async{
  final response = await http.post(Uri.parse('http://10.0.2.2:8000/api/register'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': confirmPassword
    })
  );

  if(response.statusCode == 201){
    return true;
  }
  else{
    return false;
  }
}

Future<bool> login(String email, String password) async{
  final response = await http.post(Uri.parse('http://10.0.2.2:8000/api/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }));

  //print("response: ${response.body}");
  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    token = data['access_token'];
    print("my token is $token");
    return true;
  }else{
    return false;
  }
}

Future<dynamic> getProfile() async {

  if (token == null) {
    print('No token available. Please login first.');
    return;
  }
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/profile'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data['data']);
    return data['data'];
  } else {
    // Gestion des erreurs
    print('Failed to fetch profile: ${response.body}');
    return response.body;
  }
}
