import 'package:flutter/material.dart';
import 'package:myprojects/models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _myprofile = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProfile();
  }

  void _getProfile() async {
    _myprofile = await getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "My profile",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Name: ${_myprofile['name']}",
              style: const TextStyle(
                  //fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Email: ${_myprofile['email']}",
              style: const TextStyle(
                  //fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 35,
            ),
            _myprofile['phone'] == "" || _myprofile['phone'] == null
                ? const Text(
                    "No phone number",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Phone: ${_myprofile['phone']}",
                    style: const TextStyle(
                        //fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),

            const SizedBox(height: 25,),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  fixedSize: const Size.fromWidth(300)),
              child: const Text(
                "Disconnect",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    ));
  }
}