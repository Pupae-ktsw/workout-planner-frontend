import 'dart:convert';

// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:frontend/controllers/user_controller.dart';
// import 'package:frontend/repositories/user_repo.dart';
import 'package:frontend/views/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/user.dart';

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile',
//       home: EditProfilePage(),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _EditProfilePageState();
  // _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  bool isEdited = false;
  User thisUser = User();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    const storage = FlutterSecureStorage();
    String? userJson = await storage.read(key: 'user');
    User user = User.fromJson(json.decode(userJson!));
    setState(() {
      thisUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 80,
              ),
              buildTextField('Name', thisUser.name ?? 'Name', false),
              buildTextField('E-mail', thisUser.email ?? 'E-mail', false),
              // buildTextField('Password', user.password!, true),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (isEdited) ...[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () => setState(() => isEdited = !isEdited),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {},
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                  if (!isEdited) ...[
                    GestureDetector(
                      onTap: () => setState((() => isEdited = !isEdited)),
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    'Log out',
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        enabled: isEdited ? true : false,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
