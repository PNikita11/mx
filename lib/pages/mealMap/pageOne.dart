import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_metabolix_app/pages/mealMap/pageTwo.dart';
import 'package:the_metabolix_app/pages/mealMap/pageThree.dart';
import 'package:the_metabolix_app/pages/mealMap/pageFour.dart';
import 'package:the_metabolix_app/pages/mealMap/pageFive.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  const MainAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "/home");
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
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
              'mealMap',
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
            primary: const Color(0xFFFFFFFF),
            onPrimary: const Color(0xfffa7a3b),
            side: BorderSide(color: Colors.grey),
          ),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

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

    return Container(
      width: width * 0.45,
      height: width * 0.45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(15,10),
            blurRadius: 2,
            spreadRadius: 0.9,
          ),
        ],
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center, // Center align vertically
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            width: width * 0.30,
            height: width * 0.30,
            child: Stack(
              alignment: Alignment.center, // Center align horizontally and vertically
              children: [
                Center(
                  child: Container(
                    width: width * 0.30,
                    height: width * 0.30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: width * 0.30,
                    height: width * 0.30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      border: Border.all(color: progressColor, width: width * 0.04),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: width * 0.30,
                    height: width * 0.30,
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
                      fontSize: 24,
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
              fontSize: 18,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CircularProgressBarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ADD:",
                style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mealMapSP');
              },
              child: Text('BREAKFAST'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mealMapTP');
              },
              child: Text('LUNCH'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mealMapFOP');
              },
              child: Text('SNACK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mealMapFIP');
              },
              child: Text('DINNER'),
            ),
          ],
        ),
      ],
    );
  }
}



class CarouselItem {
  final String name;
  final String descriptionLine1;
  final String descriptionLine2;
  final String descriptionLine3;

  CarouselItem({
    required this.name,
    required this.descriptionLine1,
    required this.descriptionLine2,
    required this.descriptionLine3,
  });
}

class CarouselWidget extends StatelessWidget {
  final List<CarouselItem> carouselItems = [
    CarouselItem(
      name: "Idli Sambar",
      descriptionLine1: "Breakfast Item",
      descriptionLine2: "200 KCal",
      descriptionLine3: "High Protein",
    ),
    CarouselItem(
      name: "Poha",
      descriptionLine1: "Breakfast Item",
      descriptionLine2: "250 KCal",
      descriptionLine3: "Carbohydrate Rich",
    ),
    CarouselItem(
      name: "Palak Paneer & Roti",
      descriptionLine1: "Lunch Item",
      descriptionLine2: "350 KCal",
      descriptionLine3: "Calcium Rich",
    ),
    CarouselItem(
      name: "Rajma Chawal",
      descriptionLine1: "Lunch Item",
      descriptionLine2: "380 KCal",
      descriptionLine3: "Iron Packed",
    ),
    CarouselItem(
      name: "Tea Biscuits",
      descriptionLine1: "Snack Item",
      descriptionLine2: "150 KCal",
      descriptionLine3: "Caffeine",
    ),
    CarouselItem(
      name: "Dal Makhani",
      descriptionLine1: "Lunch Item",
      descriptionLine2: "400 KCal",
      descriptionLine3: "High Protein",
    ),
    CarouselItem(
      name: "Upma",
      descriptionLine1: "Breakfast Item",
      descriptionLine2: "300 KCal",
      descriptionLine3: "Dietary Fibre",
    ),
    CarouselItem(
      name: "Vegetable Biryani",
      descriptionLine1: "Dinner Item",
      descriptionLine2: "450 KCal",
      descriptionLine3: "Dietary Fibre",
    ),
    CarouselItem(
      name: "Tandoori Chicken with Naan",
      descriptionLine1: "Dinner Item",
      descriptionLine2: "400 KCal",
      descriptionLine3: "High Protein",
    ),
    CarouselItem(
      name: "Dal Tadka with Jeera Rice",
      descriptionLine1: "Dinner Item",
      descriptionLine2: "350 KCal",
      descriptionLine3: "Dietary Fibre",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          final item = carouselItems[index];
          return Container(
            margin: const EdgeInsets.only(right: 10, top: 10, left: 5, bottom: 1),
            width: height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Here, we remove the image and use a Column to display the text.
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Suitable font size for item name
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        color: Colors.grey, // Gray color line below item name
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.descriptionLine1,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.descriptionLine2,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.descriptionLine3,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
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
      appBar: MainAppBar(appBar: AppBar(title: Text(''))),
      backgroundColor: const Color(0xFFE9E9E9),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        child: BottomNavigationBar(
          iconSize: 40,
          selectedIconTheme: IconThemeData(
            color: const Color(0xFF200087),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.white,
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello, Omkar! What's at the food table today?",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17.81,
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
                SizedBox(height: 15),
                CircularProgressBarList(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                  child: Text(
                    "RECOMMENDED TODAY...",
                    style: const TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
                CarouselWidget(),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Text(
          'TRACKERPAD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),

        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _buildCustomButton(BuildContext context, {required String title, required String route}) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, route);
    },
    child: Text(
      title,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 1),
    ),
  );
}
