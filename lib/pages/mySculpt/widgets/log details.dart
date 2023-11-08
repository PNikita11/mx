import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogDetailsPage extends StatefulWidget {
  @override
  _LogDetailsPageState createState() => _LogDetailsPageState();
}

class _LogDetailsPageState extends State<LogDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<Map<String, dynamic>> _userData;
  String? gender; // Add a gender variable

  @override
  void initState() {
    super.initState();
    // Retrieve the current user's ID from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      // Fetch user data
      _userData = fetchData(userId);
      fetchGender().then((result) {
        setState(() {
          gender = result; // Set the gender variable
        });
      });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching user data. Please try again later.'));
          } else {
            final userData = snapshot.data ?? {};
            List<Widget> dateWidgets = userData.keys.map((date) {
              Map<String, dynamic> dataForDate = userData[date];
              String? lastPeriodsDate =
              dataForDate['last_periods_date']; // Access it here

              // Print statements for debugging
              print('Date: $date');
              print('Last Periods Date: $lastPeriodsDate');

              List<Widget> children = [
                _buildDataItem('Body Weight', dataForDate['body_weight']),
                _buildDataItem(
                  'Waist (at belly button)',
                  dataForDate['waist_at_belly_button'],
                ),
                _buildDataItem(
                  'Hips at largest circumference',
                  dataForDate['hips_at_largest_circumference'],
                ),
                _buildDataItem(
                  'Thigh at largest circumference',
                  dataForDate['thigh_at_largest_circumference'],
                ),
                _buildDataItem(
                  'Chest at largest circumference',
                  dataForDate['chest_at_largest_circumference'],
                ),
                _buildDataItem(
                  'Upper Arm at largest circumference',
                  dataForDate['upper_arm_at_largest_circumference'],
                ),
                _buildDataItem('Face', dataForDate['face']),
                _buildDataItem('Calf', dataForDate['calf']),
                _buildDataItem('Neck', dataForDate['neck']),
                _buildDataItem(
                  'Waist (5 fingers above belly button)',
                  dataForDate['waist_5_fingers_above_belly_button'],
                ),
                // Add more fields here if needed
              ];
    if (gender?.toLowerCase() == 'female' && lastPeriodsDate != null){
                children.add(
                  _buildDataItem('Last Periods Date', lastPeriodsDate),
                );
                print('Displaying Last Periods Date: $lastPeriodsDate');
              }


              return Card(
                elevation: 1,
                margin: EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text(date),
                  children: children,
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

  Widget _buildDataItem(String label, dynamic value) {
    String displayValue = value != null ? value.toString() : 'N/A';
    return ListTile(
      title: Text(label),
      subtitle: Text(displayValue),
    );
  }
}
