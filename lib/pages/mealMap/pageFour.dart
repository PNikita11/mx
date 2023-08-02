import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

class SnackListScreen extends StatefulWidget {
  const SnackListScreen({Key? key}) : super(key: key);

  @override
  _SnackListScreenState createState() => _SnackListScreenState();
}

class _SnackListScreenState extends State<SnackListScreen> {
  List<String> productName = ['Poha', 'Biryani', 'Soup', 'Ladyfinger', 'Roti', 'Upma', 'Sandwich'];
  List<String> productUnit = ['KCal', 'KCal', 'KCal', 'KCal', 'KCal', 'KCal', 'KCal'];
  List<int> productPrice = [150, 850, 350, 750, 300, 900, 700];

  List<String> filteredProducts = []; // List to hold the filtered items

  @override
  void initState() {
    filteredProducts.addAll(productName); // Initialize filteredProducts with all items initially
    super.initState();
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = productName
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar(title: Text('Snack List'))),
      body: Column(
        children: [
          Container(
            height: 155, // Same height as the app bar
            child: Column(
              children: [
                Image.asset('assets/images/buffeteria.png'), // Image added below the app bar
                Text(
                  'Add Snack Item...',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    onChanged: filterProducts, // Call the filterProducts method when the text changes
                    decoration: InputDecoration(
                      hintText: 'Search for items...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns children to the start and end of the row
                      crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the top of the row
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 2),
                              Text(
                                filteredProducts[index].toString(),
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                productUnit[index].toString() + " " + r"" + productPrice[index].toString(),
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 2), // Adding right inset of 2
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              'Add Food',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
