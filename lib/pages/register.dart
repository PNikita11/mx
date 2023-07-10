import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<int> data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int currentIndex = 0;

  Widget _buildItemList(BuildContext context, int index) {
    double scaleFactor = index == currentIndex ? 1.5 : 1.0;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double itemWidth = screenWidth * scaleFactor;
    double itemHeight = screenHeight * scaleFactor;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: Center(
          child: Transform.scale(
            scale: scaleFactor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: PageView.builder(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _buildItemList(context, index);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_circle_left_outlined),
                  color: Colors.purple,
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      currentIndex = currentIndex > 0 ? currentIndex - 1 : 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_circle_right_outlined),
                  color: Colors.purple,
                  iconSize: 50,
                  onPressed: () {
                    setState(() {
                      currentIndex = currentIndex < data.length - 1
                          ? currentIndex + 1
                          : currentIndex;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
