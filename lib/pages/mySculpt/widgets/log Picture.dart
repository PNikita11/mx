import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogPicturePage extends StatefulWidget {
  @override
  _LogPicturePageState createState() => _LogPicturePageState();
}

class _LogPicturePageState extends State<LogPicturePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    // Retrieve the current user's ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      // Fetch user data
      _userData = fetchData(userId);
    } else {
      // Handle the case where the user is not authenticated
      // You can show a message or navigate to a login screen here
    }
  }

  Future<Map<String, dynamic>> fetchData(String userId) async {
    try {
      final snapshot =
      await _firestore.collection("user_metrics").doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {}; // Return an empty map if no data is found
      }
    } catch (e) {
      print('Error fetching data for user with ID: $userId');
      print('Firestore Error: $e');
      throw e; // Rethrow the error for handling elsewhere if needed
    }
  }

  void _showImagesForDate(
      BuildContext context,
      String frontImageUrl,
      String backImageUrl,
      String sideImageUrl,
      String fullImageUrl,
      String date,
      ) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayPage(
          frontImageUrl: frontImageUrl,
          backImageUrl: backImageUrl,
          sideImageUrl: sideImageUrl,
          fullImageUrl: fullImageUrl,
          title: date,
        ),
      ),
    );

    // Handle any result when the full-screen image page is popped.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Pictures'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching user data. Please try again later.'),
            );
          } else {
            final userData = snapshot.data ?? {};

            List<Widget> dateWidgets = userData.keys.map((date) {
              Map<String, dynamic> dataForDate = userData[date];
              String frontImageUrl = dataForDate["Submit Front Picture:"];
              String backImageUrl = dataForDate["Submit Back Picture:"];
              String sideImageUrl = dataForDate["Submit Side Picture:"];
              String fullImageUrl =
              dataForDate["Submit Full Picture: (casual wear)"];

              return Card(
                elevation: 1,
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    _showImagesForDate(
                      context,
                      frontImageUrl,
                      backImageUrl,
                      sideImageUrl,
                      fullImageUrl,
                      date,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      date,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }).toList();

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: dateWidgets,
            );
          }
        },
      ),
    );
  }
}

class ImageDisplayPage extends StatelessWidget {
  final String frontImageUrl;
  final String backImageUrl;
  final String sideImageUrl;
  final String fullImageUrl;
  final String title;

  ImageDisplayPage({
    required this.frontImageUrl,
    required this.backImageUrl,
    required this.sideImageUrl,
    required this.fullImageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildImageWidget(context, 'Front Image', frontImageUrl),
          _buildImageWidget(context, 'Back Image', backImageUrl),
          _buildImageWidget(context, 'Side Image', sideImageUrl),
          _buildImageWidget(context, 'Full Image', fullImageUrl),
        ],
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FullScreenImagePage(imageUrl: imageUrl, title: title),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String title;

  FullScreenImagePage({
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: LogPicturePage(),
));
