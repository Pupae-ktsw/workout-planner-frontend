import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:page_route_transition/page_route_transition.dart';

import '../controllers/user_controller.dart';
import '../models/user.dart';
import '../repositories/user_repo.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({super.key});

  @override
  State<EditPasswordPage> createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _cfNewPwController = TextEditingController();
  bool isEnable = true;
  User thisUser = User();

  var userController = UserController(UserRepo());

  @override
  void dispose() {
    _oldPwController.dispose();
    _newPwController.dispose();
    _cfNewPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          backgroundColor: Colors.red.shade600,
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(children: [
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    buildTextFormField(
                        'Current Password', _oldPwController, ''),
                    buildTextFormField('New Password', _newPwController,
                        'At least 8 characters'),
                    buildTextFormField('Confirm New Password',
                        _cfNewPwController, 'At least 8 characters'),
                    const Padding(padding: EdgeInsets.only(top: 25))
                  ]))),
              ElevatedButton(
                onPressed: isEnable == false
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          String? message = await userController.updatePassword(
                              _oldPwController.text, _newPwController.text);
                          if (message != null && message.contains('success')) {
                            Navigator.pop(context);
                            CherryToast.success(
                                    title: Text(message),
                                    toastDuration: Duration(seconds: 3),
                                    animationType: AnimationType.fromTop)
                                .show(context);
                          } else if (message != null &&
                              message.contains('Incorrect')) {
                            CherryToast.error(
                                    title: Text(message),
                                    toastDuration: Duration(seconds: 5),
                                    animationType: AnimationType.fromTop)
                                .show(context);
                          } else {
                            CherryToast.error(
                              title: const Text('Cannot Update Password'),
                              toastDuration: Duration(seconds: 5),
                              animationType: AnimationType.fromTop,
                            ).show(context);
                          }
                          // Future.delayed(Duration(seconds: 1), () {
                          _oldPwController.clear();
                          _newPwController.clear();
                          _cfNewPwController.clear();
                          // });
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600),
                child:
                    const Text('Update', style: TextStyle(color: Colors.white)),
              )
            ])));
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller, String hintText) {
    return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: TextFormField(
          validator: (value) {
            /*String field = value ?? '';
            if (labelText != 'Current Password') {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => setState(() => isEnable = false));
              if (field.isNotEmpty && field.length < 8) {
                return 'Please enter at least 8 characters';
              } else if ((_newPwController.text.isNotEmpty &&
                      _cfNewPwController.text.isNotEmpty) &&
                  (_newPwController.text != _cfNewPwController.text)) {
                return 'Password not match';
              }
            }
            if (_oldPwController.text.isNotEmpty &&
                _oldPwController.text.length >= 8 &&
                _newPwController.text.isNotEmpty &&
                _newPwController.text.length >= 8 &&
                _cfNewPwController.text.isNotEmpty &&
                _cfNewPwController.text.length >= 8) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => setState(() => isEnable = true));
            } else {
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => setState(() => isEnable = false));
            }*/
            return null;
          },
          controller: controller,
          obscureText: true,
          cursorColor: Colors.grey.shade700,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 2),
            ),
            hintText: hintText,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelStyle: TextStyle(color: Colors.grey.shade800),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }
}
