// ignore_for_file: library_private_types_in_public_api

import 'package:ffigen_test_plugin/ffigen_test_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:flutter_experiments/logger/logger.dart';

final FFIBridge _ffiBridge = FFIBridge();

class FFIGenTestPluginHelloWorldCard extends StatefulWidget {
  const FFIGenTestPluginHelloWorldCard({super.key});

  @override
  _FFIGenTestPluginHelloWorldCardState createState() =>
      _FFIGenTestPluginHelloWorldCardState();
}

class _FFIGenTestPluginHelloWorldCardState
    extends State<FFIGenTestPluginHelloWorldCard> {
  String _helloWorld = '';

  Future<void> _getHelloWorld() async {
    setState(() {
      try {
        _helloWorld = _ffiBridge.helloWorld();
      } on Exception catch (e) {
        Logger.error('Failed to get hello world: $e');
      }
    });
  }

  void _reset() {
    setState(() {
      _helloWorld = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Hello World',
      icon: const Icon(Icons.code),
      description:
          'This experiment retrieves a const char* from a C like function, converts it to a dart string and displays it in a Flutter widget.',
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (_helloWorld.isNotEmpty)
            Text(
              _helloWorld,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (_helloWorld.isNotEmpty)
            ElevatedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          if (_helloWorld.isEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              onPressed: _getHelloWorld,
              child: const Text('Say hello', style: TextStyle(fontSize: 20)),
            ),
        ],
      ),
    );
  }
}

class FFIGenTestPluginHelloWorldAsyncCard extends StatefulWidget {
  const FFIGenTestPluginHelloWorldAsyncCard({super.key});

  @override
  _FFIGenTestPluginHelloWorldAsyncCardState createState() =>
      _FFIGenTestPluginHelloWorldAsyncCardState();
}

class _FFIGenTestPluginHelloWorldAsyncCardState
    extends State<FFIGenTestPluginHelloWorldAsyncCard> {
  String _helloWorld = '';

  Future<void> _getHelloWorld() async {
    setState(() {
      _helloWorld = "awaiting async call...";
    });
    try {
      final result = await _ffiBridge.helloWorldAsync();
      setState(() {
        _helloWorld = result;
      });
    } on Exception catch (e) {
      Logger.error('Failed to get hello world: $e');
    }
  }

  void _reset() {
    setState(() {
      _helloWorld = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Hello World but async',
      icon: const Icon(Icons.code),
      description:
          'This experiment uses isolates to call a C like function that returns a const char* asynchronously. The c++ function waits for 1s before it continues with the return statement.  The result is then converted to a dart string and displayed in a Flutter widget.',
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (_helloWorld.isNotEmpty)
            Text(
              _helloWorld,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (_helloWorld.isNotEmpty)
            ElevatedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          if (_helloWorld.isEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
              ),
              onPressed: _getHelloWorld,
              child: const Text('Say hello', style: TextStyle(fontSize: 20)),
            ),
        ],
      ),
    );
  }
}

class FFIGenTestPluginCalcCard extends StatefulWidget {
  const FFIGenTestPluginCalcCard({super.key});

  @override
  State<FFIGenTestPluginCalcCard> createState() =>
      _FFIGenTestPluginCalcCardState();
}

class _FFIGenTestPluginCalcCardState extends State<FFIGenTestPluginCalcCard> {
  final TextEditingController numA = TextEditingController();
  final TextEditingController numB = TextEditingController();
  String resultText = '';

  void calc(int Function(int, int) op) async {
    int? result;
    try {
      result = op(
        int.tryParse(numA.text) ?? 0,
        int.tryParse(numB.text) ?? 0,
      );
      setState(() {
        resultText = result?.toString() ?? 'Error';
      });
    } on Exception catch (e) {
      Logger.error('Failed to execute ${op.runtimeType}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
        title: 'Calculation with integers',
        description:
            'This experiment demonstrates the use of dart ffi generated by ffigen to perform calculations with integers.',
        icon: const Icon(Icons.calculate),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number a',
                    ),
                    controller: numA,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number b',
                    ),
                    controller: numB,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
            ],
          ),
          Text('Operation', style: Theme.of(context).textTheme.titleSmall),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8.0,
            children: [
              ElevatedButton(
                onPressed: () => calc(_ffiBridge.add),
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () => calc(_ffiBridge.add2),
                child: const Text('Add (Pointer)'),
              ),
              ElevatedButton(
                onPressed: () => calc(_ffiBridge.subtract),
                child: const Text('Subtract'),
              ),
              ElevatedButton(
                onPressed: () => calc(_ffiBridge.multiply),
                child: const Text('Multiply'),
              ),
              ElevatedButton(
                onPressed: () => calc(_ffiBridge.divide),
                child: const Text('Divide'),
              ),
            ],
          ),
          const Divider(
            // Add a divider to separate the result from the button
            color: Colors.grey,
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Result:',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  resultText,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ]));
  }
}

class FFIGenTestPluginReverseStringCard extends StatefulWidget {
  const FFIGenTestPluginReverseStringCard({super.key});

  @override
  State<FFIGenTestPluginReverseStringCard> createState() =>
      _FFIGenTestPluginReverseStringCardState();
}

class _FFIGenTestPluginReverseStringCardState
    extends State<FFIGenTestPluginReverseStringCard> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'FFI Reverse String',
      description:
          'This experiment demonstrates the use of dart ffi to reverse a string with the help of C++.',
      icon: const Icon(Icons.swap_horiz),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter a string',
              ),
              controller: controller,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final reversed = _ffiBridge.reverseString(controller.text);
              controller.text = reversed;
            },
            child: const Text('Reverse String'),
          ),
        ],
      ),
    );
  }
}
