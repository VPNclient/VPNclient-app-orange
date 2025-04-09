import 'package:flutter/material.dart';
import 'package:vpn_client/pages/main/main_btn.dart';
import 'package:vpn_client/nav_bar.dart';
import 'package:vpn_client/pages/main/location_widget.dart';
import 'package:vpn_client/pages/main/stat_bar.dart';

import '../apps/apps_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VPN Client'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 24,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatBar(),
          MainBtn(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LocationWidget(),
            ],
          )
        ],
      ),
    );
  }
}
