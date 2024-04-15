import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/platform_channel/platform_channel_card.dart';
import 'package:flutter_experiments/extras_page.dart';

class PlatformChannelPage extends StatelessWidget {
  const PlatformChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Platform Channel'),
        ),
        body: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'This page demonstrates the use of platform channels to access platform code.'),
            ),
            PlatformChannelBatteryCard(),
            PlatformChannelAndroidVersionCard(),
          ],
        ),
        floatingActionButton: extrasButton(context));
  }
}
