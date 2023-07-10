import 'package:flutter/material.dart';
import 'package:the_metabolix_app/utils/routes.dart';
import 'package:the_metabolix_app/pages/splash.dart';
import 'package:the_metabolix_app/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        MyRoutes.splashRoute: (context) => SplashScreen(),
        MyRoutes.loginRoute: (context) => MyLogin(),
      },
    );
  }
}
