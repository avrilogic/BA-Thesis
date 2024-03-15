import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/pigeon_platform_channel/pigeon_cards.dart';
import 'package:flutter_experiments/settings/settings_button.dart';

class PigeonPage extends StatelessWidget {
  const PigeonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pigeon'),
      ),
      body: ListView(
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'This page demonstrates the use of platform channels with pigeon to access native code.'),
          ),
          PigeonPlatformChannelReverseStringCard(),
          PigeonPlatformChannelIntAddCard(),
          PigeonPlatformChannelComplexStructureCard(),
        ],
      ),
      floatingActionButton: settingsButton(context),
    );
  }
}
