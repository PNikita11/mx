import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrackForm(),
    );
  }
}

class TrackForm extends StatefulWidget {
  @override
  _TrackFormState createState() => _TrackFormState();
}

class _TrackFormState extends State<TrackForm> {
  final List<TextEditingController> controllers = List.generate(
    20,
        (index) => TextEditingController(),
  );

  bool _isScrolled = false;

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBar: AppBar(
          title: Text('3D ListWheelScrollView'),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            setState(() {
              _isScrolled = true;
            });
          } else if (notification is ScrollEndNotification) {
            setState(() {
              _isScrolled = false;
            });
          }
          return true;
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/mysculpttracker.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), // Adjust brightness here
                    BlendMode.srcOver,
                  ),
                ),
              ),
            ),
            ListWheelScrollView(
              itemExtent: 250.0,
              diameterRatio: 2.0,
              offAxisFraction: -0.1,
              physics: FixedExtentScrollPhysics(),
              children: List.generate(
                20,
                    (index) => Container(
                  height: 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigoAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 180.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: controllers[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8.0),
                            hintText: 'Enter text',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120.0,
              left: MediaQuery.of(context).size.width / 2 - 108.0, // Updated to center horizontally
              child: Column(
                children: [
                  AnimatedOpacity(
                    opacity: _isScrolled ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      'Swipe upwards',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Change the text color to white
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: _isScrolled ? 0.0 : 1.0,
                    duration: Duration(milliseconds: 500),
                    child: Icon(
                      Icons.arrow_upward,
                      size: 36.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your submit button onPressed logic here
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const MainAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 16,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'assets/images/login.png',
                height: appBar.preferredSize.height - 8,
                width: appBar.preferredSize.height - 0,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'mySculpt',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {},
          child: const Icon(
            Icons.notifications,
            size: 16,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5),
            maximumSize: const Size(30, 30),
            minimumSize: const Size(30, 30),
            shape: const CircleBorder(),
            primary: const Color(0xffffe6da),
            onPrimary: const Color(0xfffa7a3b),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
