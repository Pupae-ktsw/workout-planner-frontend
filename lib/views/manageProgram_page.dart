import 'package:flutter/material.dart';
import 'package:frontend/views/addProgram_page.dart';

class manageProgram extends StatelessWidget {
  const manageProgram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Manage Program",
      home: showManageProgram(),
    );
  }
}

class showManageProgram extends StatefulWidget {
  const showManageProgram({Key? key}) : super(key: key);

  @override
  _ManageProgramState createState() => _ManageProgramState();
}

class _ManageProgramState extends State<showManageProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: SafeArea(
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addProgram()));
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  Text(
                    "<Program name>",
                    style: TextStyle(fontSize: 20),
                  ),
                  Container()
                ],
              ),
              Positioned(
                bottom: 10,
                right: 50,
                child: Container(
                  height: 50,
                  width: 100,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                    onPressed: () {},
                    child: Text('next'),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 50,
                child: Container(
                  height: 50,
                  width: 100,
                  child: FloatingActionButton(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                    onPressed: () {},
                    child: Text(
                      'cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
