import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/method_channel_jni_test_plugin/method_channel_jni_test_plugin_card.dart';
import 'package:flutter_experiments/settings/settings_button.dart';

class MethodChannelJniTestPluginPage extends StatelessWidget {
  const MethodChannelJniTestPluginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MethodChannel Jni Test Plugin'),
        ),
        body: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'This page demonstrates the use of platform channels and JNI to access native code. JNI is used to call C++ code from the Android platform. The Android platform code is called using a platform channel.'),
            ),
            MethodChannelJniTestPluginHelloWorldCard(),
            MethodChannelJniTestPluginReverseStringCard(),
            MethodChannelJniTestPluginGetAnswerCard(),
          ],
        ),
        floatingActionButton: settingsButton(context));
  }
}
