import 'package:the_metabolix_app/pages/mySculpt/widgets/stats.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/appbar.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/dates.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/graph.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/info.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/steps.dart';
import 'package:the_metabolix_app/pages/mySculpt/widgets/navbar.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(appBar: AppBar()),
      body: Column(
        children: const [
          Dates(),
          Steps(),
          Graph(),
          Info(),
          Divider(height: 0),
          SizedBox(height: 0),
          NavBar(),
        ],
      ),
    );
  }
}