import 'dart:convert';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/editPassword_page.dart';
import 'package:frontend/views/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:page_route_transition/page_route_transition.dart';

import '../controllers/user_controller.dart';
import '../main.dart';
import '../models/user.dart';
import '../repositories/user_repo.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool isEdited = false;
  User thisUser = User();

  var userController = UserController(UserRepo());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String userJson = await MyApp.storage.read(key: 'user') ?? '';
    print('userJson: $userJson');
    if (userJson.isNotEmpty) {
      thisUser = User.fromJson(json.decode(userJson));
      _nameController.text = thisUser.name!;
      _emailController.text = thisUser.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.red.shade600,
          actions: [
            if (!isEdited) ...[
              IconButton(
                  onPressed: () => setState(() => isEdited = !isEdited),
                  icon: const Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                  ))
            ]
          ]),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 80,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      buildTextField(
                          'Name', _nameController, '40 Maximum characters'),
                      buildTextField(
                          'E-mail', _emailController, 'Invalid E-mail'),
                    ],
                  )),
              const SizedBox(
                height: 35,
              ),
              /*if (!isEdited) ...[
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.red.shade600,
                //   ),
                //   onPressed: () {
                //     PageRouteTransition.effect = TransitionEffect.rightToLeft;
                //     PageRouteTransition.push(
                //       context, const EditPasswordPage());
                //   },
                //   child: Text(
                //     'Change Password',
                //     style: GoogleFonts.prompt(
                //         textStyle: Theme.of(context).textTheme.bodyText2),
                //   )),

                // TextButton(
                //     onPressed: () {
                //       PageRouteTransition.effect = TransitionEffect.rightToLeft;
                //       PageRouteTransition.push(
                //           context, const EditPasswordPage());
                //     },
                //     child: Text('Change Password',
                //         style: TextStyle(color: Colors.grey.shade800)))
              ],*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (isEdited) ...[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        setState(() {
                          _nameController.text = thisUser.name!;
                          _emailController.text = thisUser.email!;
                          isEdited = !isEdited;
                        });
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            thisUser.name = _nameController.text;
                            thisUser.email = _emailController.text;
                            User? updatedUser =
                                await userController.updateUser(thisUser);
                            loadData();
                            setState(() {
                              isEdited = !isEdited;
                            });
                            if (updatedUser != null) {
                              // loadData();
                              // setState(() {
                              //   isEdited = !isEdited;
                              // });
                              CherryToast.success(
                                      title: const Text(
                                          'Update user successfully'))
                                  .show(context);
                            } else {
                              CherryToast.error(
                                      title: const Text('Update user FAILED'))
                                  .show(context);
                            }
                          }
                        },
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              // const Divider(
              //   thickness: 0.5,
              //   color: Colors.black,
              // ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(width: 2.5, color: Colors.red.shade600),
                      shadowColor: Colors.white),
                  onPressed: () {
                    PageRouteTransition.effect = TransitionEffect.rightToLeft;
                    PageRouteTransition.push(context, const EditPasswordPage());
                  },
                  child: Text(
                    'Change Password',
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2),
                  )),
              const SizedBox(
                height: 10,
              ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
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
      String labelText, TextEditingController controller, String validateText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: ((String? value) {
          String field = value ?? '';
          if (labelText == 'E-mail') {
            return field.contains('@') ? null : validateText;
          } else if (labelText == 'Name') {
            return field.isNotEmpty && field.length <= 40 ? null : validateText;
          }
          return '';
        }),
        controller: controller,
        enabled: isEdited ? true : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
