import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
              child: LoadingAnimationWidget.beat(
                size: 50,
                color: Colors.pinkAccent,
              ),
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
        child: Text('Welcome to MySculpt TP Page!'),
      ),
    );
  }
}
