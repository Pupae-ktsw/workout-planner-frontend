import 'package:flutter/material.dart';
// import 'package:frontend/widgets/calendar_widget.dart';

class PlannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planner'),
      ),
      body: Center(child: Text('Planner', style: TextStyle(fontSize: 20))),
    );
  }
}
