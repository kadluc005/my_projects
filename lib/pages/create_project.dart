import 'package:flutter/material.dart';
import 'package:myprojects/models/projects_model.dart';
import 'package:myprojects/pages/projects_page.dart';

class CreateProject extends StatelessWidget {
  const CreateProject({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _dureeController = TextEditingController();
    final _descriptionController = TextEditingController();
    var project;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 35),
            child: Column(
              children: [
                const Text(
                  "Add a new project",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _nameController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.create),
                            hintText: 'Project name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the name of the project";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _dureeController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.watch_later_outlined),
                            hintText: 'Duration'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the duration";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Description'),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          project = await create_project(
                              _nameController.text,
                              int.parse(_dureeController.text),
                              _descriptionController.text);
                          if (project) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Project created successfuly")));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProjectsPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Error")));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            fixedSize: const Size.fromWidth(600)),
                        child: const Text(
                          "Add",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
