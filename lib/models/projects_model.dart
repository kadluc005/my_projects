import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myprojects/models/user_model.dart';

Future<bool> create_project(String name, int duree, String description) async {
  var profile = await getProfile();
  var student_id = profile['data']['id'];
  if (token == null) {
    print('No token available. Please login first.');
    return false;
  }
  final response = await http.post(Uri.parse("http://10.0.2.2:8000/api/creer_projet"),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'etudiant_id': student_id,
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

Future<List<Map<String, dynamic>>> getProjects () async {
  if(token == null){
    //print('No token available. Please login first.');
    return Future.error("No token available. Please login first.");
  }
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/list_projets'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }
  );

  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data['data']);
    //return data['data'];
    List<dynamic> projects = data['data'];
    return projects.map((project) => project as Map<String, dynamic>).toList();
  }else{
    return Future.error("You don't have any project");
  }


}

Future<Map<String, dynamic>> getProjectDetails(int id) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/details_projet/$id'),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['data'] as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load project details');
  }
}

Future<List<Map<String, dynamic>>> updateProjects () async {
  if(token == null){
    //print('No token available. Please login first.');
    return Future.error("No token available. Please login first.");
  }
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/update_project'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
  );

  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    //print(data['data']);
    //return data['data'];
    List<dynamic> projects = data['data'];
    return projects.map((project) => project as Map<String, dynamic>).toList();
  }else{
    return Future.error("You don't have any project");
  }


}