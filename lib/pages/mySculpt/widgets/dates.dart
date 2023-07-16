import 'package:flutter/material.dart';
import 'package:the_metabolix_app/pages/helper.dart';

class Dates extends StatelessWidget {
  const Dates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateBox> dateBoxes = [];

    // DateTime date = DateTime.parse('2021-11-08');
    DateTime date = DateTime.now().subtract(const Duration(days: 3));

    for (int i = 0; i < 6; i++) {
      dateBoxes.add(DateBox(date: date, active: i == 3));
      date = date.add(const Duration(days: 1));
    }

    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: QuoteBox(),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dateBoxes,
          ),
        ),
      ],
    );
  }
}

class DateBox extends StatelessWidget {
  final bool active;
  final DateTime date;

  const DateBox({
    Key? key,
    this.active = false,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      decoration: BoxDecoration(
        gradient: active
            ? const LinearGradient(
          colors: [Color(0xff92e2ff), Color(0xFF0C1AA8)],
          begin: Alignment.topCenter,
        )
            : null,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xffffffff),
        ),
      ),
      child: DefaultTextStyle.merge(
        style: active ? const TextStyle(color: Colors.white) : null,
        child: Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black87,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Text(
                  date.day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              daysOfWeek[date.weekday]!,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuoteBox extends StatelessWidget {
  final List<String> quotes = [
    "He who has health has hope and he who has hope has everything",
    "Nothing is impossible. The word itself says I'm possible.",
    "Your body will be around a lot longer than that expensive handbag. Invest in yourself.",
    "Reading is to the mind what exercise is to the body",
    "A healthy outside starts from the inside",
    "It is health that is real wealth and not pieces of gold and silver",
    "Physical fitness is not only one of the most important keys to a healthy body, it is the basis of dynamic and creative intellectual activity",
    "Time and health are two precious assets that we don’t recognize and appreciate until they have been depleted",
  ];

  @override
  Widget build(BuildContext context) {
    int quoteIndex = DateTime.now().difference(DateTime(2021, 11, 8)).inHours ~/ 24 % quotes.length;
    String quote = quotes[quoteIndex];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          quote,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
