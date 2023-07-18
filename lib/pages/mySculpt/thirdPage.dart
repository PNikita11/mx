import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CongratulationsPage(),
      routes: {
        "/mySculptFPRoute": (context) => MySculptDashboard(),
      },
    );
  }
}

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/animated tick mysculpt.gif',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.width * 0.95, // Increased height by 5
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // Center align the text
                  children: [
                    Text(
                      "Congratulations!",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                    SizedBox(height: 12),
                    Text(
                      "You have successfully submitted your mySculpt body tracking metrics...",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                    SizedBox(height: 12),
                    Text(
                      "That's one big step towards achieving your fitness goals!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                    SizedBox(height: 12),
                    Text(
                      "This data shall be considered for tracking, analysing and charting your overall progress...",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Added space between the black rectangle and the elliptical button
            EllipticalButton(),
          ],
        ),
      ),
    );
  }
}

class EllipticalButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/mySculptFP");
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              height: 25,
            ),
            SizedBox(width: 10),
            Text(
              "BACK TO mySculpt DASHBOARD",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center, // Center align the text
            ),
          ],
        ),
      ),
    );
  }
}

class MySculptDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mySculpt Dashboard'),
      ),
      body: Center(
        child: Text('Welcome to mySculpt Dashboard!'),
      ),
    );
  }
}
