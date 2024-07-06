import 'package:flutter/material.dart';

import '../models/projects_model.dart';

class DetailPage extends StatefulWidget {
  final int projectId;

  const DetailPage({super.key, required this.projectId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? _project ;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState(){
    super.initState();
    _getProjectDetails(widget.projectId);
  }

  void _getProjectDetails(int id) async {
    try {
      final data = await getProjectDetails(id);
      setState(() {
        _project = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _errorMessage != null
            ? Text(_errorMessage!)
            : SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Title: ${_project!['name']}",
                style: const TextStyle(
                  // fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Description: ${_project!['description']}",
                style: const TextStyle(
                  // fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Durée: ${_project!['duree']} heures",
                style: const TextStyle(
                  // fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
