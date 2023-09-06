import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/loadingPage",
      routes: {
        "/loadingPage": (context) => LoadingPage(),
        "/mySculptTP": (context) => MySculptTPPage(),
        "/mySculptSP": (context) => MySculptSPPage(),
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 7), () {
      Navigator.pushNamed(context, "/mySculptTP");
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20),
            Center(
              child: BlinkingText(
                text: "Gathering data. Parsing values. Updating Analytics.",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Align text to the center horizontally
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlinkingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  BlinkingText({required this.text, required this.style, this.textAlign = TextAlign.left});

  @override
  _BlinkingTextState createState() => _BlinkingTextState();
}

class _BlinkingTextState extends State<BlinkingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animation = IntTween(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value == 0 ? 0.0 : 1.0,
          child: Text(widget.text, style: widget.style, textAlign: widget.textAlign),
        );
      },
    );
  }
}

class MySculptTPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MySculpt TP Page'),
      ),
      body: Center(
        child: Info(),
      ),
    );
  }
}

class MySculptSPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MySculpt SP Page'),
      ),
      body: Center(
        child: Text('Welcome to MySculpt SP Page!'),
      ),
    );
  }
}

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late Timer _timer;
  int _currentIndex = 0;
  List<Map<String, String>> _statsData = [
    {'value': '345', 'unit': 'kcal', 'label': 'Calories'},
    {'value': '3.6', 'unit': 'km', 'label': 'Distance'},
    {'value': '1.5', 'unit': 'hr', 'label': 'Hours'},
    {'value': '188', 'unit': 'in', 'label': 'Hip Circumference'},
    {'value': '200', 'unit': 'cm', 'label': 'Thigh Circumference'},
    {'value': '80', 'unit': 'kg', 'label': 'Body Weight'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 2) % _statsData.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildStatsBox(int index) {
    final Map<String, String> stats = _statsData[index];
    return _StatsBox(
      child: Stats(
        value: stats['value']!,
        unit: stats['unit']!,
        label: stats['label']!,
        isCenterAligned:
        stats['label'] == 'Hip Circumference' ||
            stats['label'] == 'Thigh Circumference',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatsBox((_currentIndex) % _statsData.length),
                  _buildStatsBox((_currentIndex + 1) % _statsData.length),
                  _buildStatsBox((_currentIndex + 2) % _statsData.length),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue.shade50,
                      Colors.lightBlue.shade100,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: FutureBuilder<String?>(
                  future: fetchUsername(),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading username');
                    } else {
                      final userUsername = snapshot.data ?? 'User';
                      return Text(
                        '$userUsername... It\'s been a while you sent us your mySculpt body metrics! It\'s time to track your progress!!',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              elevation: 5,
              shape: const CircleBorder(),



              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.indigoAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      String? gender = await fetchGender();
                      if (gender != null && gender == "Male") {
                        Navigator.pushNamed(context, "/mySculptSPMale");
                      } else if (gender != null && gender == "Female") {
                        Navigator.pushNamed(context, "/mySculptSP");
                      } else {
                        Navigator.pushNamed(context, "/home");
                      }
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Track'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to fetch the username
  Future<String?> fetchUsername() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // If a user is logged in, return their display name
      return currentUser.displayName;
    } else {
      return null; // Return null if no user is logged in
    }
  }

  // Fetching Gender from Firestore
  Future<String?> fetchGender() async {
    User? user = FirebaseAuth.instance.currentUser;
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('RegisteredUsers')
          .doc(user!.uid)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
        userSnapshot.data() as Map<String, dynamic>;
        String? gender = userData['user_detail']['gender'];
        print(gender);
        return gender;
      } else {
        return null; // User document doesn't exist
      }
    } catch (e) {
      print('Error fetching gender: $e');
      return null;
    }
  } // End for Fetching Gender
}

class _StatsBox extends StatelessWidget {
  final Widget child;

  const _StatsBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class Stats extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  final bool isCenterAligned;

  const Stats({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
    this.isCenterAligned = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenterAligned
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: isCenterAligned ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: isCenterAligned ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
