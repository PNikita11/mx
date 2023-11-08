import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final VoidCallback onNotificationPressed; // Callback function for handling notifications

  const MainAppBar({
    Key? key,
    required this.appBar,
    required this.onNotificationPressed, // Add this parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // ... Your existing app bar code ...

      actions: [
        TextButton(
          onPressed: onNotificationPressed, // Call the callback function here
          child: const Icon(
            Icons.notifications,
            size: 16,
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5),
            maximumSize: const Size(30, 30),
            minimumSize: const Size(30, 30),
            shape: const CircleBorder(),
            primary: const Color(0xffffe6da),
            onPrimary: const Color(0xfffa7a3b),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
