import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar color to white
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black, // Set the color of the menu icon to black
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the image horizontally
          children: [
            Image.asset(
              'assets/images/metabolix splash screen.jpg',
              height: 60,
              width: 300,
              fit: BoxFit.contain, // Ensure the image fits within the app bar
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle drawer item 1 tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle drawer item 2 tap
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  selectedTileColor: Colors.indigoAccent.shade100,
                  title: Text(
                    "Rajesh Singh",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                      const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    "MetaboliX has provided me with an experience of.....",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.person,
                          ),
                          title: Text("My Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.bag,
                          ),
                          title: Text("My Bag"),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text("Settings"),
                      ),
                      PopupMenuItem(
                        child: Text("About Us"),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                          ),
                          title: Text("Log Out"),
                        ),
                      ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const NetworkImage(
                        'https://images.unsplash.com/photo-1644982647869-e1337f992828?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Good Evening, Omkar",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                            top: 24,
                            bottom: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: GridB(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: showBtmAppBr
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.heart,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.cart,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.bell,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: 1, // Set equal width and height
      ),
      itemCount: 4,
      itemBuilder: (_, index) {
        List<String> imagePaths = [
          'assets/icons/dietInery icon.png',
          'assets/icons/mealMap icon.png',
          'assets/icons/metaFit icon.png',
          'assets/icons/mySculpt icon.png',
        ];
        List<String> labels = [
          'dietInery',
          'mealMap',
          'metaFit',
          'mySculpt',
        ];
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.amberAccent.shade100,
            border: Border.all(color: Colors.blue, width: 2.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePaths[index],
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8.0),
                Text(
                  labels[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
