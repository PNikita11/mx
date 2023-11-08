import 'package:the_metabolix_app/pages/mySculpt/widgets/Measurement.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/appbar.dart';

import 'package:the_metabolix_app/pages/mySculpt/widgets/info.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/quotebox.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // Function to handle notifications
  void handleNotifications() {
    // Add your notification handling logic here
    // This function will be called when the notification button is pressed
    // You can show a notification dialog or navigate to a notifications screen, for example.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        appBar: AppBar(),
        onNotificationPressed: handleNotifications, // Pass the function here
      ),
      body: Column(
        children: [
          QuoteBox(),
          Measurement(),
          Info(),
              NavBar(
                userId: 'your_user_id', // Replace with the actual user ID
                selectedImages: [], // Provide your selectedImages data
                uploadedImageUrls: [], // Provide your uploadedImageUrls data
              )



        ],
      ),
    );
  }
}
