import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/ffi_simple_test_plugin/ffi_simple_test_plugin_cards.dart';
import 'package:flutter_experiments/settings/settings_button.dart';

class FFISimpleTestPluginPage extends StatelessWidget {
  const FFISimpleTestPluginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FFI Simple Test Plugin'),
        ),
        body: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'This page demonstrates the use of dart ffi. The interfaces were manually written.'),
            ),
            FFISimpleTestPluginHelloWorldCard(),
            FFISimpleTestPluginCalcCard(),
            FFISimpleTestPluginReverseStringCard(),
          ],
        ),
        floatingActionButton: settingsButton(context));
  }
}
