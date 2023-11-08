import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: Measurement(),
  ));
}

class ChartSampleData {
  ChartSampleData(this.date, this.value);
  final DateTime date;
  final double value;
}

class Measurement extends StatefulWidget {
  @override
  _MeasurementState createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  String selectedMeasurement = 'Weight'; // Default to 'Weight'
  String? selectedPeriod;

  // Map measurement names to Firestore field names
  final Map<String, String> measurementFields = {
    'Weight': 'body_weight',
    'Neck': 'neck',
    'Waist': 'waist_5_fingers_above_belly_button',
    'Hips': 'hips_at_largest_circumference',
  };

  // List of available measurements (excluding 'Height')
  final List<String> measurements = ['Weight', 'Neck', 'Waist', 'Hips'];

  // List of available periods
  final List<String> periods = [
    'Last 7 days',
    'Last 30 days',
    'Last 6 months',
    'Last 1 year',
  ];

  Future<List<ChartSampleData>> fetchData() async {
    try {
      final QuerySnapshot<Object?> snapshot = await FirebaseFirestore.instance
          .collection("user_metrics")
          .get();

      print('Querying Firestore for $selectedMeasurement');
      print('Number of documents received: ${snapshot.docs.length}');

      final List<ChartSampleData> chartData = snapshot.docs.map((QueryDocumentSnapshot<Object?> document) {
        final Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        DateTime date = DateTime.now(); // Default date
        double value;

        if (data.containsKey('timestamp') && data['timestamp'] != null) {
          try {
            final Timestamp timestamp = data['timestamp'] as Timestamp;
            date = timestamp.toDate();
          } catch (e) {
            print('Error parsing timestamp: $e');
          }
        }

        final String field = measurementFields[selectedMeasurement] ?? '';
        if (field.isNotEmpty && data.containsKey(field)) {
          try {
            value = data[field] as double;
          } catch (e) {
            print('Error parsing $field value: $e');
            value = 0.0;
          }
        } else {
          // If the selected field is not present, set value to 0.0
          value = 0.0;
        }

        print('Document Data - Date: $date, Value: $value');

        return ChartSampleData(date, value);
      }).toList();

      return chartData.isNotEmpty ? chartData : [];
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  // Calculate the start date based on the selected period
  DateTime getStartDate() {
    DateTime endDate = DateTime.now();
    switch (selectedPeriod) {
      case 'Last 7 days':
        return endDate.subtract(Duration(days: 7));
      case 'Last 30 days':
        return endDate.subtract(Duration(days: 30));
      case 'Last 6 months':
        return endDate.subtract(Duration(days: 180));
      case 'Last 1 year':
        return endDate.subtract(Duration(days: 365));
      default:
        return endDate.subtract(Duration(days: 7)); // Default to last 7 days
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    Row(
    children: [
    Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: DropdownButton<String>(
            hint: Text('Select Measurement'), // Hint text
            value: selectedMeasurement,
            items: [
              // Measurement items
              for (String measurement in measurements)
                DropdownMenuItem<String>(
                  value: measurement,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Measurement', // Dropdown title for measurements
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(measurement),
                    ],
                  ),
                ),
            ],
            onChanged: (String? newValue) {
              setState(() {
                selectedMeasurement =
                    newValue ?? 'Weight'; // Default to 'Weight'
              });
            },
          ),
        ),
      ],
    ),
    ),
    SizedBox(width: 20), // Add some spacing between the dropdowns
    Expanded(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Align(
    alignment: Alignment.center,
    child: DropdownButton<String>(
    hint: Text('Select Period'), // Hint text
    value: selectedPeriod,
    items: [
    // Period items
    for (String period in periods)
    DropdownMenuItem<String>(
    value: period,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Period', // Dropdown title for periods
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    Text(period),
    ],
    ),
    ),
    ],
    onChanged: (String? newValue) {
    setState(() {
    selectedPeriod = newValue;
    });
    },
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    SizedBox(height: 16),
    // Display the line chart based on the selected measurement and period
    Container(
    width: double.infinity,
    height: 300,
    child: FutureBuilder<List<ChartSampleData>>(
    future: fetchData(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError || !snapshot.hasData) {
    return Text('An error occurred while fetching data.');
    } else {
    final List<ChartSampleData> chartData = snapshot.data!;

    if (chartData.isNotEmpty) {
    return SfCartesianChart(
    primaryXAxis: DateTimeAxis(
    // Customize your X-axis configuration here
    dateFormat: DateFormat('MM/dd'), // Format the date as 'MM/dd'
    intervalType: DateTimeIntervalType.days,
    interval: 1, // Display labels for each day
    labelRotation: 45,
    labelIntersectAction: AxisLabelIntersectAction.rotate45,
    ),
    primaryYAxis: NumericAxis(
    // Customize your Y-axis configuration here
    minimum: 0, // Set your desired minimum value here
    maximum: getMaxValue(chartData), // Calculate the maximum value based on data
    ),
    series: <ChartSeries<ChartSampleData, DateTime>>[
    LineSeries<ChartSampleData, DateTime>(
    yAxisName: 'Value',
    dataSource: chartData,
    xValueMapper: (ChartSampleData data, _) => data.date,
    yValueMapper: (ChartSampleData data, _) => data.value,
    color: Colors.blue,
    ),
    ],
    );
    } else {
    return Text('No data available.');
    }
    }
    },
    ),
    ),

    ],
    );
  }

  // Calculate the maximum Y-axis value based on the data
  double getMaxValue(List<ChartSampleData> chartData) {
    double maxValue = 0;
    for (ChartSampleData data in chartData) {
      if (data.value > maxValue) {
        maxValue = data.value;
      }
    }
    return maxValue;
  }
}
