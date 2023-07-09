import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 250,
            ),
            Image(
              image: AssetImage("assets/images/metabolix splash screen.jpg"),
              width: 780,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "..........where science meets fitness",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: 'MontSerrat', // Set the font to 'MontSerrat'
              ),
            ),
            SizedBox(
              height: 150,
            ),
            SpinKitPulsingGrid(
              color: Colors.redAccent,
              size: 75.0,
              duration: const Duration(milliseconds: 1000),
            ),
          ],
        ),
      ),
    );
  }
}
