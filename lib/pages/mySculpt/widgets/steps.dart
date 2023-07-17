import 'package:the_metabolix_app/pages/helper.dart';
import 'package:flutter/material.dart';

class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String steps = formatNumber(randBetween(50, 90));
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          Text(
            'Your Monthly Progress...',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '90%',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}