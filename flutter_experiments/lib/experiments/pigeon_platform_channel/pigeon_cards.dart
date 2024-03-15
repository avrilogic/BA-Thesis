import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:flutter_experiments/experiments/pigeon_platform_channel/messages.g.dart';
import 'package:flutter_experiments/logger/logger.dart';

class PigeonPlatformChannelReverseStringCard extends StatefulWidget {
  const PigeonPlatformChannelReverseStringCard({super.key});

  @override
  State<PigeonPlatformChannelReverseStringCard> createState() =>
      _PigeonPlatformChannelReverseStringCardState();
}

class _PigeonPlatformChannelReverseStringCardState
    extends State<PigeonPlatformChannelReverseStringCard> {
  final TextEditingController controller = TextEditingController();
  final MethodChannelPigeon pigeon = MethodChannelPigeon();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Pigeon Reverse String',
      description:
          'This experiment sends a string to a via pigeon created Method channel and reverses the string with platform code (java).',
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
              final reversed = await pigeon.reverse(controller.text);
              controller.text = reversed;
            },
            child: const Text('Reverse String'),
          ),
        ],
      ),
    );
  }
}

class PigeonPlatformChannelIntAddCard extends StatefulWidget {
  const PigeonPlatformChannelIntAddCard({super.key});

  @override
  State<PigeonPlatformChannelIntAddCard> createState() =>
      _PigeonPlatformChannelIntAddCardState();
}

class _PigeonPlatformChannelIntAddCardState
    extends State<PigeonPlatformChannelIntAddCard> {
  final MethodChannelPigeon pigeon = MethodChannelPigeon();
  final TextEditingController numA = TextEditingController();
  final TextEditingController numB = TextEditingController();
  String resultText = '';

  void calc(_CalcOperations op) async {
    int? result;
    try {
      switch (op) {
        case _CalcOperations.add:
          result = await pigeon.add(int.parse(numA.text), int.parse(numB.text));
          break;
        case _CalcOperations.subtract:
          result =
              await pigeon.subtract(int.parse(numA.text), int.parse(numB.text));
          break;
        case _CalcOperations.multiply:
          result =
              await pigeon.multiply(int.parse(numA.text), int.parse(numB.text));
          break;
        case _CalcOperations.divide:
          result =
              await pigeon.divide(int.parse(numA.text), int.parse(numB.text));
          break;
      }
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
        title: 'Pigeon Calc Integers',
        description:
            'This experiment sends two integers to a via pigeon created Method channel and adds the integers with platform code (java).',
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
                onPressed: () => calc(_CalcOperations.add),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => calc(_CalcOperations.subtract),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => calc(_CalcOperations.multiply),
              ),
              IconButton(
                icon: const Icon(Icons.linear_scale),
                onPressed: () => calc(_CalcOperations.divide),
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

enum _CalcOperations { add, subtract, multiply, divide }

class PigeonPlatformChannelComplexStructureCard extends StatefulWidget {
  const PigeonPlatformChannelComplexStructureCard({super.key});

  @override
  State<PigeonPlatformChannelComplexStructureCard> createState() =>
      _PigeonPlatformChannelComplexStructureCardState();
}

class _PigeonPlatformChannelComplexStructureCardState
    extends State<PigeonPlatformChannelComplexStructureCard> {
  final MethodChannelPigeon pigeonProvider = MethodChannelPigeon();
  final TextEditingController numA = TextEditingController();
  final TextEditingController numB = TextEditingController();
  ComplexStructure? data;

  void requestComplexData() async {
    try {
      final result = await pigeonProvider.getComplexStructure();
      setState(() {
        data = result;
      });
    } on PlatformException catch (e) {
      Logger.error('Failed to get complex data: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Pigeon Complex Structure',
      description:
          'This experiment sends a request to a via pigeon created Method channel and receives a complex structure with platform code (java).',
      icon: const Icon(Icons.data_usage),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: requestComplexData,
            child: const Text('Request Complex Data'),
          ),
          if (data != null) ...[
            Text('Complex Structure',
                style: Theme.of(context).textTheme.titleSmall),
            Text('Type of data: ${data?.runtimeType.toString()}'),
            Text('a: ${data!.a}'),
            Text('b: ${data!.b}'),
            Text('c: ${data!.c}'),
            Text('List: ${data?.myList.toString() ?? 'null'}'),
            Text('Map: ${data?.myKvMap.toString() ?? 'null'}'),
          ] else
            const Text('No data received'),
        ],
      ),
    );
  }
}
