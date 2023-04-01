import 'package:flutter/material.dart';
import 'package:frontend/models/dayOfProgram.dart';
import 'package:frontend/models/youtubeVid.dart';
import 'package:frontend/views/addProgram_page.dart';

class DayOfProgramManage extends StatefulWidget {
  const DayOfProgramManage({
    Key? key,
    required this.youtubeVid,
  }) : super(key: key);

  final YoutubeVid youtubeVid;

  @override
  State<DayOfProgramManage> createState() => _DayOfProgramManageState();
}

class _DayOfProgramManageState extends State<DayOfProgramManage> {
  List<DayOfProgram> _dayOfProgramList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowAddProgramPage()));
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 36,
                    ),
                  ),
                  Text("programName", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
