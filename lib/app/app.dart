import 'package:flutter/material.dart';
import 'package:trackrinatr/app/theme.dart';
import 'package:trackrinatr/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'trackrinatr',
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}