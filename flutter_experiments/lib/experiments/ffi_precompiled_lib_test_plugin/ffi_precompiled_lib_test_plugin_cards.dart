// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:ffi_precompiled_lib_test_plugin/ffi_precompiled_lib_test_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:flutter_experiments/logger/logger.dart';

final _lib = FfiPrecompiledLibTestPlugin();
final _sideloadLib = SideloadLib();

class FFIPrecompiledLibTestPluginCard extends StatefulWidget {
  const FFIPrecompiledLibTestPluginCard({super.key});

  @override
  _FFIPrecompiledLibTestPluginCardState createState() =>
      _FFIPrecompiledLibTestPluginCardState();
}

class _FFIPrecompiledLibTestPluginCardState
    extends State<FFIPrecompiledLibTestPluginCard> {
  String _helloWorld = '';

  Future<void> _getHelloWorld() async {
    try {
      final result = _lib.helloWorld();
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
      title: 'Hello World',
      icon: const Icon(Icons.code),
      description:
          'This experiment interacts with a precompiled library that is bundled with the app.',
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

class FFIPrecompiledLibTestPluginSideloadCard extends StatefulWidget {
  const FFIPrecompiledLibTestPluginSideloadCard({super.key});

  @override
  _FFIPrecompiledLibTestPluginSideloadCardState createState() =>
      _FFIPrecompiledLibTestPluginSideloadCardState();
}

class _FFIPrecompiledLibTestPluginSideloadCardState
    extends State<FFIPrecompiledLibTestPluginSideloadCard> {
  String _outputText = '';
  String _architecture = '';
  File? _download;
  bool _sideloadLoaded = false;
  List<String> _connections = [];

  void _getConnections() {
    _sideloadLib.getConnections().then(
          (value) => setState(
            () => print(_connections = value),
          ),
        );
  }

  void _getArchitecture() {
    _sideloadLib.getCompilerArchitecture().then(
          (value) => setState(
            () {
              _architecture = value;
            },
          ),
        );
  }

  void _downloadSideload() async {
    try {
      await _sideloadLib
          .downloadFile(
              '${_connections.first}/lib/$_architecture/libsideloadlib.so',
              "sideload.so")
          .then(
            (value) => setState(
              () {
                _download = value;
              },
            ),
          );
    } on Exception catch (e) {
      Logger.error('Failed to download: $e');
    }
  }

  void _loadSideloadFile() {
    try {
      _sideloadLib.sideload(_download!);
      setState(() {
        _sideloadLoaded = true;
      });
    } on Exception catch (e) {
      Logger.error('Failed to sideload: $e');
    }
  }

  void _unloadSideloadFile() {
    try {
      _sideloadLib.unload();
      setState(() {
        _sideloadLoaded = false;
      });
    } on Exception catch (e) {
      Logger.error('Failed to unload: $e');
    }
  }

  void _reset() {
    setState(() {
      _outputText = '';
    });
  }

  void _helloWorld() {
    try {
      final result = _sideloadLib.helloWorld();
      setState(() {
        _outputText = result ?? '';
      });
    } on Exception catch (e) {
      Logger.error('Failed to say hello: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Sideload',
      icon: const Icon(Icons.code),
      description:
          'For this experiment, the precompiled library is downloaded and loaded at runtime. In order to work the file the sideload_server needs to be started first.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Architecture: $_architecture',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _architecture.isEmpty ? null : Colors.green),
                onPressed: _getArchitecture,
                child: const Text('Get Architecture'),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Available Connections:"),
                  ..._connections.map((e) => Text(
                        e,
                        style: const TextStyle(fontSize: 8),
                      ))
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _connections.isEmpty ? null : Colors.green),
                onPressed: _getConnections,
                child: const Text('Get Connections'),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Text(
                  'Downloaded: ${_download != null ? 'Yes' : 'No'}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (_download != null)
                  IconButton(
                    onPressed: () {
                      _download?.delete();
                      setState(() {
                        _download = null;
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
              ]),
              if (_connections.isNotEmpty && _architecture.isNotEmpty)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _download != null ? Colors.green : null),
                  onPressed: _downloadSideload,
                  child: const Text('Download Sideload'),
                ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sideload Loaded: ${_sideloadLoaded ? 'Yes' : 'No'}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (_sideloadLoaded)
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _unloadSideloadFile,
                  child: const Text('Unload Sideload'),
                ),
              if (!_sideloadLoaded && _download != null)
                ElevatedButton(
                  onPressed: _loadSideloadFile,
                  child: const Text('Load Sideload'),
                ),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Output: ${_outputText.isNotEmpty ? 'Available' : 'None'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (_outputText.isNotEmpty)
                    ElevatedButton(
                      onPressed: _reset,
                      child: const Text('Reset'),
                    ),
                  if (_outputText.isEmpty && _sideloadLoaded)
                    ElevatedButton(
                      onPressed: _helloWorld,
                      child: const Text('Say hello'),
                    ),
                ],
              ),
              Text(_outputText)
            ],
          ),
        ],
      ),
    );
  }
}
