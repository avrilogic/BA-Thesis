import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/ffi_precompiled_lib_test_plugin/ffi_precompiled_lib_test_plugin_cards.dart';
import 'package:flutter_experiments/extras_page.dart';

class FFIPrecompiledLibTestPluginPage extends StatelessWidget {
  const FFIPrecompiledLibTestPluginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FFI Precompiled Lib Test'),
        ),
        body: ListView(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'This gist of the experiment is the use of precompiled binary libraries in Flutter Android Apps.'),
            ),
            FFIPrecompiledLibTestPluginCard(),
            FFIPrecompiledLibTestPluginSideloadCard(),
            SizedBox(height: 60),
          ],
        ),
        floatingActionButton: extrasButton(context));
  }
}
