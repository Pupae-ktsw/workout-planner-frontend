import 'package:flutter/material.dart';

import '../widgets/calendar_widget.dart';
// import 'package:frontend/widgets/calendar_widget.dart';

class PlannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: <Widget>[
          const CalendarWidget(),
        ],
      ),
    );
  }
}
