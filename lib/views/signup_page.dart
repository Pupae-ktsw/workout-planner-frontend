import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final urlImage = 'lib/images/google.png';

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 174, 169),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_box),
                          border: InputBorder.none,
                          hintText: 'Full name'),
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 174, 169),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: InputBorder.none,
                          hintText: 'Email'),
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 174, 169),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: 'Password'),
                    )),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 174, 169),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                  Text(
                    'Sign up with Google',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
