import 'package:flutter/material.dart';
import 'dart:async';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late Timer _timer;
  int _currentIndex = 0;
  List<Map<String, String>> _statsData = [
    {'value': '345', 'unit': 'kcal', 'label': 'Calories'},
    {'value': '3.6', 'unit': 'km', 'label': 'Distance'},
    {'value': '1.5', 'unit': 'hr', 'label': 'Hours'},
    {'value': '188', 'unit': 'in', 'label': 'Hip Circumference'},
    {'value': '200', 'unit': 'cm', 'label': 'Thigh Circumference'},
    {'value': '80', 'unit': 'kg', 'label': 'Body Weight'},
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 2) % _statsData.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildStatsBox(int index) {
    final Map<String, String> stats = _statsData[index];
    return _StatsBox(
      child: Stats(
        value: stats['value']!,
        unit: stats['unit']!,
        label: stats['label']!,
        isCenterAligned:
        stats['label'] == 'Hip Circumference' ||
            stats['label'] == 'Thigh Circumference',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatsBox((_currentIndex) % _statsData.length),
                _buildStatsBox((_currentIndex + 1) % _statsData.length),
                _buildStatsBox((_currentIndex + 2) % _statsData.length),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue.shade50,
                    Colors.lightBlue.shade100,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Text(
                'Nikita... Its been a while you sent us your mySculpt body metrics! Its time to track your progress!!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 5,
            shape: const CircleBorder(),
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.indigoAccent,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.withOpacity(0.3),
                ),
                child: TextButton(
                  onPressed: () {
                    // Add your track button's onPressed logic here
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Track'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsBox extends StatelessWidget {
  final Widget child;

  const _StatsBox({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}

class Stats extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  final bool isCenterAligned;

  const Stats({
    Key? key,
    required this.value,
    required this.unit,
    required this.label,
    this.isCenterAligned = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenterAligned
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: unit,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          textAlign: isCenterAligned ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: isCenterAligned ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
