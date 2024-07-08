import 'package:flutter/material.dart';
import 'package:myprojects/models/projects_model.dart';
import 'package:myprojects/pages/create_project.dart';
import 'package:myprojects/pages/project_detail_page.dart';
import 'package:myprojects/pages/update_project.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  List<Map<String, dynamic>> _projects = [];
  bool _isLoading = true;
  String? _errorMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProjects();
  }

  void _getProjects() async {
    try {
      final data = await getProjects();
      setState(() {
        _projects = data;
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
        title: const Text("My projects"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateProject()));
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : ListView.builder(
                  itemCount: _projects.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(projectId: _projects[index]['id']),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(
                              _projects[index]['name'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle:
                                Text("Duration: ${_projects[index]['duree']}"),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const UpdateProject()));
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete, color: Colors.red,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
    );
  }
}
