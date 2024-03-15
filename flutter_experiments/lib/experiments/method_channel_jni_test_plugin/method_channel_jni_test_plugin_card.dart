import 'package:flutter/material.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:method_channel_jni_test_plugin/method_channel_jni_test_plugin.dart';

class MethodChannelJniTestPluginHelloWorldCard extends StatefulWidget {
  const MethodChannelJniTestPluginHelloWorldCard({super.key});

  @override
  _MethodChannelJniTestPluginHelloWorldCardState createState() =>
      _MethodChannelJniTestPluginHelloWorldCardState();
}

class _MethodChannelJniTestPluginHelloWorldCardState
    extends State<MethodChannelJniTestPluginHelloWorldCard> {
  final MethodChannelJniTestPlugin lib = MethodChannelJniTestPlugin();
  String _helloWorld = '';

  Future<void> _getHelloWorld() async {
    final helloWorld = await lib.getCPPHelloWorld();
    setState(() {
      _helloWorld = helloWorld;
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
      title: 'Cpp Plugin Hello World Experiment',
      icon: const Icon(Icons.code),
      description:
          'This experiment demonstrates the use of platform channels and JNI to access native code.',
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (_helloWorld.isNotEmpty)
            Text(
              _helloWorld,
              style: Theme.of(context).textTheme.headlineSmall,
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

class MethodChannelJniTestPluginReverseStringCard extends StatefulWidget {
  const MethodChannelJniTestPluginReverseStringCard({super.key});

  @override
  State<MethodChannelJniTestPluginReverseStringCard> createState() =>
      _MethodChannelJniTestPluginReverseStringCardState();
}

class _MethodChannelJniTestPluginReverseStringCardState
    extends State<MethodChannelJniTestPluginReverseStringCard> {
  final TextEditingController controller = TextEditingController();
  final MethodChannelJniTestPlugin lib = MethodChannelJniTestPlugin();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'C++ Reverse String',
      description:
          'This experiment sends a string to a via pigeon created Method channel and from there via JNI to a C++ function that reverses the string and returns it.',
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
              final reversed = await lib.reverse(controller.text);
              controller.text = reversed;
            },
            child: const Text('Reverse String'),
          ),
        ],
      ),
    );
  }
}

class MethodChannelJniTestPluginGetAnswerCard extends StatefulWidget {
  const MethodChannelJniTestPluginGetAnswerCard({super.key});

  @override
  State<MethodChannelJniTestPluginGetAnswerCard> createState() =>
      _MethodChannelJniTestPluginGetAnswerCardState();
}

class _MethodChannelJniTestPluginGetAnswerCardState
    extends State<MethodChannelJniTestPluginGetAnswerCard> {
  final MethodChannelJniTestPlugin lib = MethodChannelJniTestPlugin();
  int _answer = 0;

  Future<void> _getAnswer() async {
    final answer = await lib.getAnswer();
    if (answer == 0) {
      Fluttertoast.showToast(
        msg: "Need to think first!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromARGB(255, 239, 213, 82),
        textColor: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 16.0,
      );
    }
    setState(() {
      _answer = answer;
    });
  }

  Future<void> _provideAnswer() async {
    await lib.provideAnswer();
  }

  void _reset() {
    setState(() {
      _answer = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'C++ Get Answer',
      description:
          'This experiment sends a request to a via pigeon created Method channel and from there via JNI to a C++ function that returns sets a value inside a java class from C++',
      icon: const Icon(Icons.question_answer),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (_answer != 0)
            Text(
              'The answer is $_answer',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          if (_answer != 0)
            ElevatedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          if (_answer == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _getAnswer,
                  child:
                      const Text('Get Answer', style: TextStyle(fontSize: 20)),
                ),
                ElevatedButton(
                  onPressed: _provideAnswer,
                  child: const Text('Think', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
