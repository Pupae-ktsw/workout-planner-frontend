import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:frontend/components/circle_tile.dart';
import 'package:frontend/config.dart';
// import 'package:frontend/views/home_page.dart';
import 'package:frontend/main.dart';
import 'package:frontend/views/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const urlImage = 'lib/images/google.png';
    // const urlImage2 = 'lib/images/facebook.png';

    return Scaffold(
      backgroundColor: Colors.red,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome!',
                  style: GoogleFonts.lobster(
                      textStyle: Theme.of(context).textTheme.headline1)),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white.withOpacity(0.8),
              ),
              SizedBox(height: 20),

              //Email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 174, 169),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) => input != null
                          ? !input.contains("@")
                              ? "Invalid Email"
                              : null
                          : "Please, enter your Email",
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 174, 169),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              //log in button
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    onPressed: (() {
                      login();
                    }),
                    child: const Text('Login'),
                  )
                  /*Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text(
                    'Log in',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),*/
                  ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignupPage();
                      }));
                    },
                    child: Text(
                      'Register now',
                      style: GoogleFonts.prompt(
                          textStyle: Theme.of(context).textTheme.bodyText1,
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 52.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Or Log in with',
                      style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1.0,
                      color: Colors.black,
                    ))
                  ],
                ),
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
                  Text('Log in with Google',
                      style: GoogleFonts.prompt(
                        textStyle: Theme.of(context).textTheme.bodyText2,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    var url = Config.apiURL + Config.loginAPI;
    if (emailController.text.isNotEmpty && pwController.text.isNotEmpty) {
      var response = await http.post(Uri.parse(url),
          body: ({
            "email": emailController.text,
            "password": pwController.text
          }));
      if (response.statusCode == 200) {
        final storage = FlutterSecureStorage();
        var body = json.decode(response.body);
        String token = body['accessToken'];
        print(token);
        await storage.write(key: 'accessToken', value: token);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Invalid Credentials')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter your email and password')));
    }
  }
}
