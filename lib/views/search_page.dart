import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String programName = 'programName';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 36,
                ),
                Text(programName, style: TextStyle(fontSize: 18)),
                Container()
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  width: 350,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        programName = value;
                      });
                    },
                    // controller: null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.blue))),
                  ),
                ),
                Container(
                  width: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
