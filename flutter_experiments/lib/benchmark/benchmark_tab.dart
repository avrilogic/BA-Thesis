import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_experiments/benchmark/benchmark_data.dart';
import 'package:flutter_experiments/benchmark/benchmark_runner.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class BenchmarkTab extends StatelessWidget {
  BenchmarkTab({super.key});
  final BenchmarkRunner _runner = BenchmarkRunner();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Benchmark'),
                  const Divider(),
                  ListenableBuilder(
                      listenable: _runner,
                      builder: (context, child) {
                        return Column(children: [
                          Text('Benchmarks: ${_runner.length}'),
                          Text('Current: ${_runner.current}'),
                        ]);
                      }),
                ],
              ),
            ),
          ),
        ),
        // display amount

        AddCard(
          add: (task) => _runner.addBenchmark(task),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _runner.run();
              },
              child: const Text('Run Benchmark'),
            ),
            ElevatedButton(
              onPressed: () {
                _runner.clearBenchmarks();
              },
              child: const Text('Clear Benchmarks'),
            ),
          ],
        ),

        BenchmarkList(
          runner: _runner,
        ),
      ],
    );
  }
}

class BenchmarkList extends StatelessWidget {
  final BenchmarkRunner runner;
  const BenchmarkList({super.key, required this.runner});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: runner,
      builder: (context, child) {
        return Column(children: [
          const Text('Benchmarks'),
          const Divider(),
          if (runner.length == 0) const Text('No benchmarks added yet'),
          ..._buildBenchmarkList(),
        ]);
      },
    );
  }

  List<Widget> _buildBenchmarkList() {
    return runner.benchmarks
        .map((e) => ListTile(
              title: Text(
                  '${e.type.name} / ${_bytesToString(e.bytes)} / ${e.iterations}'),
              trailing: e.status == BenchmarkStatus.running
                  ? const CircularProgressIndicator()
                  : e.status == BenchmarkStatus.completed
                      ? const Icon(Icons.check)
                      : e.status == BenchmarkStatus.failed
                          ? const Icon(Icons.error)
                          : null,
              subtitle: e.status == BenchmarkStatus.completed
                  ? Text('Results: ${e.results()}')
                  : null,
            ))
        .toList();
  }
}

class AddCard extends StatefulWidget {
  final Function(BenchmarkTask task) add;
  const AddCard({
    super.key,
    required this.add,
  });

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  List<BenchmarkType> types = BenchmarkType.values.toList();
  // max bytes is 1MB
  static const upperLimit = 1 * 1024 * 1024;
  static const sliderSteps = 1024;
  int bytesMin = 1;
  int steps = 200;
  int bytesMax = 512 * 1024;
  bool multipleByteCombinations = false;
  int iterations = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Text('Add a new benchmark'),
            // switch Type dropdown
            MultiSelectDialogField<BenchmarkType>(
              items: BenchmarkType.values
                  .map((type) =>
                      MultiSelectItem<BenchmarkType>(type, type.toString()))
                  .toList(),
              title: Text("Benchmark Types"),
              selectedColor: Colors.blue,
              initialValue: types,
              onConfirm: (values) {
                setState(() {
                  types = values;
                });
              },
            ),

            // bytes input start
            Text('Iterations ($iterations):'),
            Slider(
              value: iterations.toDouble(),
              min: 1,
              max: 1000,
              divisions: 100,
              label: iterations.toString(),
              onChanged: (double value) {
                setState(() {
                  iterations = value.toInt();
                });
              },
            ),
            const Text('Bytes:', style: TextStyle(fontSize: 16)),
            SwitchListTile(
              title: const Text('Multiple Byte Combinations'),
              value: multipleByteCombinations,
              onChanged: (bool value) {
                setState(() {
                  multipleByteCombinations = value;
                });
              },
            ),
            Text('Min (${_bytesToString(bytesMin)}):'),
            Slider(
              value: bytesMin.toDouble(),
              min: 1,
              max: upperLimit.toDouble(),
              divisions: sliderSteps,
              label: _bytesToString(bytesMin),
              onChanged: (double value) {
                setState(() {
                  bytesMin = value.toInt();
                  if (bytesMin > bytesMax) bytesMax = bytesMin;
                  final delta = bytesMax - bytesMin;
                  if (steps > delta) {
                    steps = delta;
                  }
                });
              },
            ),

            if (multipleByteCombinations) ...[
              Text('Max (${_bytesToString(bytesMax)}):'),
              Slider(
                value: bytesMax.toDouble(),
                min: bytesMin.toDouble(),
                max: upperLimit.toDouble(),
                divisions: sliderSteps,
                label: _bytesToString(bytesMax),
                onChanged: (double value) {
                  setState(() {
                    bytesMax = value.toInt();
                    if (bytesMax < bytesMin) bytesMin = bytesMax;
                    final delta = bytesMax - bytesMin;
                    if (steps > delta) {
                      steps = delta;
                    }
                  });
                },
              ),
              Text('Steps ($steps):'),
              Slider(
                value: steps.toDouble(),
                min: 0,
                max: min(500, bytesMax.toDouble() - bytesMin.toDouble()),
                divisions: sliderSteps,
                label: steps.toString(),
                onChanged: (double value) {
                  setState(() {
                    steps = value.toInt();
                  });
                },
              ),
            ],
            // iterations input
            Text(
                'Current settings will result in ${types.length * (multipleByteCombinations ? steps : 1)} combinations and ${types.length * (multipleByteCombinations ? steps : 1) * iterations} computations. Click "Add Benchmark" to add them to the list.'),
            ElevatedButton(
              onPressed: () {
                for (final type in types) {
                  if (multipleByteCombinations && steps > 0) {
                    final stepSize = (bytesMax - bytesMin) ~/ steps;
                    for (var bytes = bytesMin;
                        bytes <= bytesMax;
                        bytes += stepSize) {
                      widget.add(BenchmarkTask(
                        type: type,
                        bytes: bytes,
                        iterations: iterations,
                      ));
                    }
                  } else {
                    widget.add(BenchmarkTask(
                      type: type,
                      bytes: bytesMin,
                      iterations: iterations,
                    ));
                  }
                }
              },
              child: const Text('Add Benchmark'),
            ),
          ],
        ),
      ),
    );
  }
}

String _bytesToString(int byteSite) {
  if (byteSite < 1024) {
    return '$byteSite B';
  }
  if (byteSite < 1024 * 1024) {
    return '${(byteSite / 1024).toStringAsFixed(2)} KB';
  }
  if (byteSite < 1024 * 1024 * 1024) {
    return '${(byteSite / 1024 / 1024).toStringAsFixed(2)} MB';
  }
  return '${(byteSite / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
}
