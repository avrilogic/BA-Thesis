import 'package:flutter/material.dart';

Widget settingsButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.pushNamed(context, '/options');
    },
    tooltip: 'Options',
    child: const Icon(Icons.settings),
  );
}
