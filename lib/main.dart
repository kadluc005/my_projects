import 'package:flutter/material.dart';
import 'package:myprojects/models/user_model.dart';
import 'package:myprojects/pages/home_page.dart';
import 'package:myprojects/pages/register_page.dart';

var my_token = token;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: my_token == null? const RegisterPage(): const HomePage(),
    );
  }
}
