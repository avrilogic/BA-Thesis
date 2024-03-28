import 'dart:ffi';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:ffi/ffi.dart';
import 'package:ffi_precompiled_lib_test_plugin/connections.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

export 'ips.dart';

const String _libName = 'customlib';

/// The dynamic library in which the symbols for [FfiPrecompiledLibTestPluginBindings] can be found.
final DynamicLibrary _dylib = () {
  _throwIfUnsupportedPlatform();
  return DynamicLibrary.open('lib$_libName.so');
}();

typedef HelloWorldFunc = Pointer<Utf8> Function();

class FfiPrecompiledLibTestPlugin {
  late HelloWorldFunc _helloWorld;
  FfiPrecompiledLibTestPlugin() {
    _helloWorld = _dylib
        .lookup<NativeFunction<HelloWorldFunc>>('hello_world')
        .asFunction<HelloWorldFunc>();
  }
  String helloWorld() {
    final result = _helloWorld();
    final String resultDart = result.toDartString();
    return resultDart;
  }
}

class SideloadLib {
  HelloWorldFunc? _helloWorld;
  DynamicLibrary? _sideload;

  bool get available => _sideload != null && _helloWorld != null;

  void sideloadFromUrl(
    String url,
  ) async {
    final file = await downloadFile(url, "sideload.so");
    sideload(file);
  }

  Future<File> downloadFile(String url, String filename) async {
    try {
      // Getting the response from the URL
      final response = await http.get(Uri.parse(url));
      // File path to save the download
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$filename';
      // Saving the file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      // Handle the error
      throw Exception("Error downloading file: $e");
    }
  }

  DynamicLibrary sideload(File file) {
    _sideload = DynamicLibrary.open(file.path);
    _helloWorld = _sideload!
        .lookup<NativeFunction<HelloWorldFunc>>('hello_world')
        .asFunction<HelloWorldFunc>();
    return _sideload!;
  }

  void unload() {
    _sideload?.close();
    _sideload = null;
    _helloWorld = null;
  }

  String? helloWorld() {
    final result = _helloWorld?.call();
    final resultDart = result?.toDartString();
    return resultDart;
  }

  Future<List<String>> getConnections() async {
    List<String> valid = [];
    for (final connection in connections) {
      final uri = Uri.parse('$connection/check');
      try {
        final response =
            await http.get(uri).timeout(const Duration(milliseconds: 50));
        if (response.statusCode == 200 && response.body == "OK") {
          valid.add(connection);
        }
      } catch (e) {
        debugPrint('Failed to connect to $connection: $e');
      }
    }

    return valid;
  }

  Future<String> getCompilerArchitecture() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      await _throwIfUnsupportedArchitecture(androidInfo.supportedAbis.first);
      return androidInfo.supportedAbis.first;
    }

    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}

Future<void> _throwIfUnsupportedArchitecture(String architecture) {
  final supported = ['arm64-v8a', 'armeabi-v7a', 'x86_64', 'x86'];
  if (!supported.contains(architecture)) {
    throw UnsupportedError('Unsupported architecture: $architecture');
  }
  return Future.value();
}

void _throwIfUnsupportedPlatform() {
  if (!Platform.isAndroid) {
    throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
  }
}
