import 'package:flutter/material.dart';
import 'package:the_metabolix_app/pages/mySculpt/firstPage.dart';
import 'package:the_metabolix_app/pages/mySculpt/loadingPage.dart';
import 'package:the_metabolix_app/pages/mySculpt/secondPage_F.dart';
import 'package:the_metabolix_app/pages/mySculpt/thirdPage.dart';
import 'package:the_metabolix_app/utils/routes.dart';
import 'package:the_metabolix_app/pages/screens/splash.dart';
import 'package:the_metabolix_app/pages/screens/login.dart';
import 'package:the_metabolix_app/pages/screens/register.dart';
import 'package:the_metabolix_app/pages/screens/homepage.dart';



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
        "/": (context) => MyLogin(),
        MyRoutes.splashRoute: (context) => SplashScreen(),
        MyRoutes.loginRoute: (context) => MyLogin(),
        MyRoutes.registerRoute: (context) => RegisterPage(),
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.mySculptFPRoute: (context) => DetailsPage(),
        MyRoutes.mySculptSPRoute: (context) => TrackForm(),
        MyRoutes.mySculptTPRoute: (context) => CongratulationsPage(),
        MyRoutes.mySculptloadRoute: (context) => LoadingPage(),
      },
    );
  }
}
