import 'dart:isolate';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:the_metabolix_app/firebase_options.dart';
import 'package:the_metabolix_app/pages/dietnary/firstpage.dart';
import 'package:the_metabolix_app/pages/mealMap/pageFive.dart';
import 'package:the_metabolix_app/pages/mealMap/pageFour.dart';
import 'package:the_metabolix_app/pages/mealMap/pageThree.dart';
import 'package:the_metabolix_app/pages/mealMap/pageTwo.dart';
import 'package:the_metabolix_app/pages/mySculpt/firstPage.dart';
import 'package:the_metabolix_app/pages/mySculpt/loadingPage.dart';
import 'package:the_metabolix_app/pages/mySculpt/secondPage_F.dart';
import 'package:the_metabolix_app/pages/mySculpt/secondPage_M.dart';
import 'package:the_metabolix_app/pages/mySculpt/thirdPage.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/log%20Picture.dart';
import 'package:the_metabolix_app/pages/screens/splash.dart';
import 'package:the_metabolix_app/pages/screens/login.dart';
import 'package:the_metabolix_app/pages/screens/register.dart';
import 'package:the_metabolix_app/pages/screens/homepage.dart';
import 'package:the_metabolix_app/pages/mealMap/pageOne.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/log details.dart';
import 'package:the_metabolix_app/utils/routes.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

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
        MyRoutes.registerRoute: (context) => RegisterPage(),
        MyRoutes.homeRoute: (context) => Home(),
        MyRoutes.mySculptFPRoute: (context) => DetailsPage(),
        MyRoutes.LogDetailsPage: (context) => LogDetailsPage(),
        MyRoutes.LogPicturePage: (context) => LogPicturePage(),
        MyRoutes.mySculptSPRoute: (context) => TrackForm(),
        MyRoutes.mySculptSPMaleRoute: (context) => TrackForm_M(),
        MyRoutes.mySculptTPRoute: (context) => CongratulationsPage(),
        MyRoutes.mySculptloadRoute: (context) => LoadingPage(),
        MyRoutes.mealMapFPRoute: (context) => ProfileScreen(),
        MyRoutes.mealMapSPRoute: (context) => ProductListScreen(),
        MyRoutes.mealMapTPRoute: (context) => LunchListScreen(),
        MyRoutes.mealMapFOPRoute: (context) => SnackListScreen(),
        MyRoutes.mealMapFIPRoute: (context) => DinnerListScreen(),
        MyRoutes.dietInaryFPRoute: (context) => FirstPage(),
      },
    );
  }
}

//just a check