import 'package:flutter/material.dart';
import 'package:the_metabolix_app/pages/dietnary/widgets/calendar.dart';
import 'package:the_metabolix_app/pages/dietnary/widgets/appbar.dart';
import 'package:the_metabolix_app/pages/dietnary/widgets/piechart.dart'; // Import the MainAppBar widget

class FirstPage extends StatelessWidget {
  // Function to import the CalendarWidget
  Widget buildCalendarWidget() {
    return CalendarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(appBar: AppBar()), // Use the MainAppBar here
      body: Column(
        children: [
          Expanded(
            child: buildCalendarWidget(), // Use the import function to add the CalendarWidget
          ),
          // Expanded(
          //   child: Tabs(), // Use the import function to add the CalendarWidget
          // ),
        ],
      ),
    );
  }
}
