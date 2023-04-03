import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:frontend/components/format_text.dart';
import 'package:frontend/provider/programProvider.dart';
import 'package:frontend/views/home_page.dart';
import 'package:frontend/views/login_page.dart';
import 'package:frontend/views/planner_page.dart';
import 'package:frontend/views/profile_page.dart';
import 'package:frontend/views/program_page.dart';
import 'package:frontend/views/search_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgramProvider()),
      ],
      child: MaterialApp(
        theme: appTheme(),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
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
    Homepage(),
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
        body: screens[currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.red.shade600,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.whatshot_sharp,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
