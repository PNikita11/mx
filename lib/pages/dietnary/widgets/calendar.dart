import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // Import 'intl' for date formatting

void main() {
  runApp(MyApp());
}

bool isSameDay(DateTime day1, DateTime day2) {
  return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Widget Example',
      home: CalendarWidget(),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  List<int> _generateYearList() {
    int currentYear = DateTime.now().year;
    List<int> years = [];
    for (int year = 2000; year <= currentYear + 100; year++) {
      years.add(year);
    }
    return years;
  }

  String _getMonthName(int month) {
    return DateFormat('MMMM').format(DateTime(_focusedDay.year, month));
  }

  String _getMonthAbbreviation(int month) {
    return DateFormat('MMM').format(DateTime(_focusedDay.year, month));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Monthly Analytics', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<int>(
                value: _focusedDay.year,
                items: _generateYearList().map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(year.toString()),
                  );
                }).toList(),
                onChanged: (int? selectedYear) {
                  setState(() {
                    _focusedDay = DateTime(selectedYear!, _focusedDay.month, _focusedDay.day);
                  });
                },
              ),
              SizedBox(
                height: 400,
                child: Column(
                  children: [
                    Expanded(
                      child: TableCalendar(
                        calendarFormat: _calendarFormat,
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        focusedDay: _focusedDay,
                        firstDay: _firstDay,
                        lastDay: _lastDay,
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        calendarStyle: const CalendarStyle(
                          weekendTextStyle: TextStyle(
                            color: Colors.red,
                          ),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          headerTitleBuilder: (context, day) {
                            final String monthName = _getMonthName(day.month);
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$monthName ${day.year}'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // This function will be called when the button is pressed
                  // You can define the behavior of the button here
                  // For example, you can navigate to another screen:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MonthlyAnalyticsScreen()),
                  );
                },
                child: Text(
                  'View Monthly Analytics', // Text displayed on the button
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  // You can customize the button's appearance further using other properties
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthlyAnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your Monthly Analytics view
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Analytics'),
      ),
      body: Center(
        child: Text('Monthly Analytics content goes here.'),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with the content of the Another Screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Screen'),
      ),
      body: Center(
        child: Text('Content of the Another Screen goes here.'),
      ),
    );
  }
}
