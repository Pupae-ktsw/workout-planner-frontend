import 'package:flutter/material.dart';

class ProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Program Page'),
      ),
      body: Center(child: Text('Programs', style: TextStyle(fontSize: 20))),
    );
  }
}
