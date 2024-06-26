import 'package:flutter/material.dart';
import 'package:run_to_claim/app/app.dart';
import 'package:run_to_claim/counter/counter.dart';
import 'package:run_to_claim/explore/explore.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const AvatarDrawerHeader(),
          ListTile(
            title: const Text('Explore'),
            onTap: () {
              Navigator.of(context).pushReplacement(ExplorePage.route());
            },
          ),
          ListTile(
            title: const Text('Counter'),
            onTap: () {
              Navigator.of(context).pushReplacement(CounterPage.route());
            },
          ),
        ],
      ),
    );
  }
}
