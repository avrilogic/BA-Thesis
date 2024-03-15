import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:ffi/ffi.dart';
import 'package:ffigen_test_plugin/ffigen_test_plugin_bindings_generated.dart';
import 'package:flutter/cupertino.dart';

const String _libName = 'ffigen_test_plugin';

/// The dynamic library in which the symbols for [FfigenTestPluginBindings] can be found.
final DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();
// moved out of the class to be able to use it in the isolate
final _bindings = FfigenTestPluginBindings(_dylib);

class FFIBridge {
  /// The dynamic library in which the symbols for [FfigenTestPluginBindings] can be found.

  String helloWorld() {
    // Call the hello_world function from the generated bindings.
    // Need to cast the result to Utf8 and then to Dart string, because the
    // const char* is not always a valid UTF-8 string with a null terminator.
    return _bindings.hello_world().cast<Utf8>().toDartString();
  }

  Future<String> helloWorldAsync() async {
    // completer that can be awaited till the result is available
    final resultCompleter = Completer<String>();

    // Create a receive port to receive the result from the helper isolate.
    final receivePort = ReceivePort();
    receivePort.listen((result) {
      if (result is String) {
        resultCompleter.complete(result);
      } else if (result is Error) {
        resultCompleter.completeError(result); // Handle the error
      } else {
        resultCompleter.completeError(
            UnsupportedError('Unknown message type: ${result.runtimeType}'));
      }
    }).onDone(() {
      receivePort.close(); // Close the port when done
    });

    await Isolate.spawn((SendPort sendPort) async {
      debugPrint('Isolate spawned');
      try {
        // Call the hello_world function from the generated bindings.
        final result =
            _bindings.hello_world_delayed().cast<Utf8>().toDartString();
        // Send the result back to the main isolate.
        sendPort.send(result);
      } catch (e) {
        sendPort.send(e.toString());
      }
    }, receivePort.sendPort);

    // Return the future that will complete when the result is available.
    return resultCompleter.future;
  }

  String reverseString(String input) {
    // Convert the input string to a native Utf8 string.
    final inputCString = input.toNativeUtf8();
    // Call the reverse function from the generated bindings.
    final result = _bindings.reverse(inputCString as Pointer<Char>);
    // Free the input string.
    calloc.free(inputCString);
    // Convert the result to a Dart string.
    return result.cast<Utf8>().toDartString();
  }

  int add(int a, int b) {
    return _bindings.add(a, b);
  }

  int subtract(int a, int b) {
    return _bindings.subtract(a, b);
  }

  int multiply(int a, int b) {
    return _bindings.multiply(a, b);
  }

  int divide(int a, int b) {
    return _bindings.divide(a, b);
  }

  int add2(int a, int b) {
    final aPointer = calloc<Int>()..value = a;
    final bPointer = calloc<Int>()..value = b;
    final resultPointer = _bindings.add2(aPointer, bPointer);
    final result = resultPointer.value;
    calloc.free(aPointer);
    calloc.free(bPointer);
    calloc.free(resultPointer);
    return result;
  }
}
