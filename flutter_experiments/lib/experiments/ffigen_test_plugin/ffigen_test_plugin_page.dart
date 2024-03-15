import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/ffigen_test_plugin/ffigen_test_plugin_cards.dart';
import 'package:flutter_experiments/settings/settings_button.dart';

class FFIGenTestPluginPage extends StatelessWidget {
  const FFIGenTestPluginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FFIGen Test Plugin'),
        ),
        body: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'The experiments on this page demonstrate the use of dart ffi in conjunction with ffigen. Ffigen allows the automatic code generation of dart ffi bindings for C libraries.'),
            ),
            FFIGenTestPluginHelloWorldCard(),
            FFIGenTestPluginHelloWorldAsyncCard(),
            FFIGenTestPluginCalcCard(),
            FFIGenTestPluginReverseStringCard(),
          ],
        ),
        floatingActionButton: settingsButton(context));
  }
}
