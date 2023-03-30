import 'package:flutter/material.dart';
import 'package:frontend/views/addProgram_page.dart';

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
                                builder: (context) => showAddProgramPage()));
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
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
