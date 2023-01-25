import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/home_page.dart';
import 'package:frontend/views/planner_page.dart';
import 'package:frontend/views/profile_page.dart';
import 'package:frontend/views/program_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    PlannerPage(),
    ProgramPage(),
    ProfilePage(),
  ];
  final items = <Widget>[
    const Icon(Icons.home, color: Colors.white),
    const Icon(Icons.calendar_month_rounded, color: Colors.white),
    const Icon(Icons.whatshot_sharp, color: Colors.white),
    const Icon(Icons.person, color: Colors.white),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.red.shade600)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              screens[currentIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: CurvedNavigationBar(
                  height: 60,
                  color: Colors.red.shade600,
                  backgroundColor: Colors.transparent,
                  animationDuration: Duration(milliseconds: 300),
                  onTap: (index) => setState(() => currentIndex = index),
                  items: items,
                ),
              )
            ],
          ),
        ));
  }
}
