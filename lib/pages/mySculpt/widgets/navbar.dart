import 'package:flutter/material.dart';

import 'log Picture.dart';
import 'log details.dart';



class NavBar extends StatelessWidget {
  final String userId;
  final List<Map<String, dynamic>> selectedImages;
  final List<String> uploadedImageUrls; // Define the parameter here

  const NavBar({
    Key? key,
    required this.userId,
    required this.selectedImages,
    required this.uploadedImageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: const Color(0xfff8f8f8),
      child: IconTheme(
        data: const IconThemeData(color: Color(0xffabadb4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.home,
                  ),
                  const Text('Home'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LogDetailsPage(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.assignment,
                  ),
                  const Text('Log Details'),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LogPicturePage(


                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.photo_camera,
                  ),
                  const Text('Log Picture'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
