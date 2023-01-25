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
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.grey.shade900,
                // boxShadow: const [
                //   BoxShadow(
                //     blurRadius: 10.0,
                //     color: Colors.black,
                //   ),
                // ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: 10,
                separatorBuilder: ((context, index) {
                  return const SizedBox(height: 12);
                }),
                itemBuilder: ((context, index) {
                  return Container(
                    height: 100,
                    width: 20,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                            image: NetworkImage(
                                'https://www.purina.co.uk/sites/default/files/styles/ttt_image_510/public/2020-11/Hero-Small-Mobile-cats.jpg?itok=hEnG1ehe'),
                          ),
                        ),
                        Text('data')
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
