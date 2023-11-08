import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:the_metabolix_app/utils/routes.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _zoomInAnimation;
  late Animation<Offset> _flyInAnimation;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _zoomInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _flyInAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
      ),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();

    // Delayed navigation to the login page after 4 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _checkLoggedInUser();
    });
  }


  // Checking if User had already login
  void _checkLoggedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is already logged in, navigate to the home page
      Navigator.pushReplacementNamed(context, MyRoutes.homeRoute);
    }
    else {
      // User will navigate ti Login Page
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 190,
              child: SlideTransition(
                position: _flyInAnimation,
                child: ScaleTransition(
                  scale: _zoomInAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 60), // Adjust the top padding as needed
                  child: Image(
                    image: AssetImage("assets/images/metabolix logo.png"), // Replace with your combined image path
                    width: 400, // Adjust the width as needed
                    height: 400, // Adjust the height as needed
                  ),
                ),
              ),
            ),
            ),
            SizedBox(
              height: 2,
            ),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Text(
                ".... where science meets fitness",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'MontSerrat',
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            SlideTransition(
              position: _flyInAnimation,
              child: ScaleTransition(
                scale: _zoomInAnimation,
                child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.deepPurpleAccent,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


