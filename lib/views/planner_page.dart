import 'package:flutter/material.dart';

import '../widgets/calendar_widget.dart';
// import 'package:frontend/widgets/calendar_widget.dart';

class PlannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CalendarWidget(),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.grey.shade900,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10.0,
                      color: Colors.black,
                    ),
                  ]),
              child: ListView(children: [
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade100),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade200),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade400),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade100),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade200),
                ),
                Container(
                  height: 100,
                  width: 20,
                  decoration: BoxDecoration(color: Colors.amber.shade400),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
