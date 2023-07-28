import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CircularProgressBar extends StatelessWidget {
  final String title;
  final int leftAmount;
  final double progress;
  final Color progressColor;

  const CircularProgressBar({
    Key? key,
    required this.title,
    required this.leftAmount,
    required this.progress,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          width: width * 0.45, // Changed width to occupy full width of the page
          height: width * 0.4, // Changed height to make each progress bar larger
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: width * 0.35,
                  height: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: width * 0.35,
                  height: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: progressColor, width: width * 0.04),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: width * 0.35,
                  height: width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(color: progressColor, width: width * 0.04),
                    gradient: SweepGradient(
                      startAngle: -90.0,
                      endAngle: -90.0 + 360 * progress,
                      colors: [progressColor, progressColor, Colors.transparent, Colors.transparent],
                      stops: [0, 1 - progress, 1 - progress, 1],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Increased font size for percentage text
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          "${leftAmount}g left",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18, // Increased font size for leftAmount text
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class CircularProgressBarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularProgressBar(
              title: "BREAKFAST",
              leftAmount: 72,
              progress: 0.3,
              progressColor: Colors.green,
            ),
            CircularProgressBar(
              title: "SNACKS",
              leftAmount: 252,
              progress: 0.9,
              progressColor: Colors.red,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularProgressBar(
              title: "LUNCH",
              leftAmount: 61,
              progress: 0.1,
              progressColor: Colors.yellow,
            ),
            CircularProgressBar(
              title: "DINNER",
              leftAmount: 50,
              progress: 0.5,
              progressColor: Colors.orange,
            ),
          ],
        ),
      ],
    );
  }
}

class CarouselItem {
  final String imagePath;
  final String name;

  CarouselItem({
    required this.imagePath,
    required this.name,
  });
}

class CarouselWidget extends StatelessWidget {
  final List<CarouselItem> carouselItems = [
    CarouselItem(imagePath: "assets/meal1.png", name: "Meal 1"),
    CarouselItem(imagePath: "assets/meal2.png", name: "Meal 2"),
    CarouselItem(imagePath: "assets/meal3.png", name: "Meal 3"),
    CarouselItem(imagePath: "assets/meal4.png", name: "Meal 4"),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          final item = carouselItems[index];
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(item.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.name,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 40,
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF200087),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Icon(Icons.home),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.search),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                child: Icon(Icons.person),
                padding: const EdgeInsets.only(top: 8.0),
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello, Omkar!",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${DateFormat("EEEE").format(today)}, ${DateFormat("d MMMM").format(today)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressBarList(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                  child: Text(
                    "MEALS FOR TODAY",
                    style: const TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                CarouselWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
