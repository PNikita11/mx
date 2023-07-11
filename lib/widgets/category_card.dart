import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;

  const CategoryCard({
    Key? key, // Make the key parameter nullable
    required this.svgSrc,
    required this.title,
    required this.press,
  }) : super(key: key ?? const ValueKey<String>('category_card'));

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.blueAccent, // Replace with a valid color
            ),
          ],
        ),
      ),
    );
  }
}
