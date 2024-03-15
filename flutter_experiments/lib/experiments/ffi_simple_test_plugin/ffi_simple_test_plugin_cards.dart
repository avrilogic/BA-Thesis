// ignore_for_file: library_private_types_in_public_api

import 'package:ffi_simple_test_plugin/ffi_simple_test_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:flutter_experiments/logger/logger.dart';

final FFIBridge _ffiBridge = FFIBridge();

class FFISimpleTestPluginHelloWorldCard extends StatefulWidget {
  const FFISimpleTestPluginHelloWorldCard({super.key});

  @override
  _FFISimpleTestPluginHelloWorldCardState createState() =>
      _FFISimpleTestPluginHelloWorldCardState();
}

class _FFISimpleTestPluginHelloWorldCardState
    extends State<FFISimpleTestPluginHelloWorldCard> {
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

class FFISimpleTestPluginCalcCard extends StatefulWidget {
  const FFISimpleTestPluginCalcCard({super.key});

  @override
  State<FFISimpleTestPluginCalcCard> createState() =>
      _FFISimpleTestPluginCalcCardState();
}

class _FFISimpleTestPluginCalcCardState
    extends State<FFISimpleTestPluginCalcCard> {
  final TextEditingController numA = TextEditingController();
  final TextEditingController numB = TextEditingController();
  String resultText = '';

  void calc(CalculationOperation op) async {
    double? result;
    try {
      result = _ffiBridge.calculate(
        double.tryParse(numA.text) ?? 0,
        double.tryParse(numB.text) ?? 0,
        op,
      );
      setState(() {
        resultText = result?.toString() ?? 'Error';
      });
    } on Exception catch (e) {
      Logger.error('Failed to ${op.name}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
        title: 'Calculation with double',
        description:
            'This experiment demonstrates the use of dart ffi to perform a calculation with double values. The calculation request is delivered as a struct to the native part.',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => calc(CalculationOperation.add),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => calc(CalculationOperation.subtract),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => calc(CalculationOperation.multiply),
              ),
              IconButton(
                icon: const Icon(Icons.linear_scale),
                onPressed: () => calc(CalculationOperation.divide),
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

class FFISimpleTestPluginReverseStringCard extends StatefulWidget {
  const FFISimpleTestPluginReverseStringCard({super.key});

  @override
  State<FFISimpleTestPluginReverseStringCard> createState() =>
      _FFISimpleTestPluginReverseStringCardState();
}

class _FFISimpleTestPluginReverseStringCardState
    extends State<FFISimpleTestPluginReverseStringCard> {
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
            onPressed: () async {
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
