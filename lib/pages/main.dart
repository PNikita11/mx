import 'package:flutter/material.dart';
import 'package:the_metabolix_app/utils/routes.dart';
import 'package:the_metabolix_app/pages/splash.dart';
import 'package:the_metabolix_app/pages/login.dart';
import 'package:the_metabolix_app/pages/register.dart';
import 'package:the_metabolix_app/pages/homepage.dart';


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
        "/": (context) => Home(),
        MyRoutes.splashRoute: (context) => SplashScreen(),
        MyRoutes.loginRoute: (context) => MyLogin(),
        MyRoutes.registerRoute: (context) => RegisterPage(),
      },
    );
  }
}
