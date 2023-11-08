import 'package:flutter/material.dart';
import 'form_header_widget.dart'; // Adjust the path as needed


class FormHeaderWidget extends StatelessWidget {
  final AssetImage image;
  final String title;
  final CrossAxisAlignment crossAxisAlignment;
  final double heightBetween;
  final TextAlign textAlign;

  const FormHeaderWidget({
    required this.image,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.heightBetween = 30.0,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Image(image: image),
        SizedBox(height: 20.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: textAlign,
        ),
        SizedBox(height: 10.0),

        SizedBox(height: heightBetween),
      ],
    );
  }
}

// TODO Implement this library.