import 'package:flutter/material.dart';
import 'package:myprojects/pages/profile_page.dart';
import 'package:myprojects/pages/projects_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  setCurrentIndex(index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Projects'),
          NavigationDestination(icon: Icon(Icons.person), label: 'My profil')
        ],
        onDestinationSelected: (value){
          setCurrentIndex(value);
        },
      ),
      body: [
        const ProjectsPage(),
        const ProfilePage()
      ][_currentIndex]
    );
  }
}

