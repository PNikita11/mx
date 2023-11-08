// TODO Implement this library.
import 'package:flutter/material.dart';

class QuoteBox extends StatelessWidget {
   QuoteBox({Key? key}) : super(key: key);
  final List<String> quotes = [
    "He who has health has hope....He who has hope has everything",
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
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow,
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
      child: Text(
        quote,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: QuoteBox(),
    ),
  ));
}
