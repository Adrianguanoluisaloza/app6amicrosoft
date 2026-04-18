import 'package:flutter/material.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Microsoft Equi Micros 6AA',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const MainScreen(),
    );
  }
}
