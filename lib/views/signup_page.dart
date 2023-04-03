import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/views/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repositories/user_repo.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final urlImage = 'lib/images/google.png';
    UserController userController = UserController(UserRepo());
    User user = User();
    String? confirmPassword;

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      backgroundColor: Colors.red,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text('Sign up',
                  style: GoogleFonts.lobster(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 20),

              //form sign up
              Column(
                children: [
                  //Fullname
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 174, 169),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.account_box),
                              border: InputBorder.none,
                              hintText: 'Full name'),
                          onChanged: (value) {
                            user.name = value;
                          },
                        )),
                  ),
                  SizedBox(height: 20),

                  //Email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 174, 169),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          onChanged: (value) {
                            user.email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: InputBorder.none,
                              hintText: 'Email'),
                        )),
                  ),
                  SizedBox(height: 20),

                  //Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 174, 169),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          onChanged: (value) {
                            user.password = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: InputBorder.none,
                              hintText: 'Password'),
                        )),
                  ),
                  SizedBox(height: 20),

                  //Confirm password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 174, 169),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextFormField(
                          onChanged: (value) {
                            confirmPassword = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              border: InputBorder.none,
                              hintText: 'Confirm password'),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //Sign up button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: InkWell(
                      onTap: () {
                        userController.postUser(user);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          'Sign up',
                          style: GoogleFonts.prompt(
                              textStyle: Theme.of(context).textTheme.bodyText1,
                              color: Colors.white),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                color: Colors.black,
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(urlImage),
                      backgroundColor: Colors.white,
                      radius: 20,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Sign up with Google',
                      style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
