import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:ffi_simple_test_plugin/ffi_types.dart';

class FFIBridge {
  static const String _libName = 'ffi_simple_test_plugin';
  late final HelloWorld _helloWorld;
  late final ReverseString _reverseString;
  late final FreeString _freeString;
  late final Calculate _calculate;

  late final DynamicLibrary _dylib;

  FFIBridge() {
    if (Platform.isMacOS || Platform.isIOS) {
      _dylib = DynamicLibrary.open('$_libName.framework/$_libName');
    } else if (Platform.isAndroid || Platform.isLinux) {
      _dylib = DynamicLibrary.open('lib$_libName.so');
    } else {
      throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
    }
    _helloWorld =
        _dylib.lookupFunction<HelloWorldNative, HelloWorld>('hello_world');
    _reverseString =
        _dylib.lookupFunction<ReverseStringNative, ReverseString>('reverse');
    _freeString =
        _dylib.lookupFunction<FreeStringNative, FreeString>('free_string');
    _calculate = _dylib.lookupFunction<CalculateNative, Calculate>('calculate');
  }

  String helloWorld() {
    final CString result = _helloWorld();
    final String resultDart = result.toDartString();
    return resultDart;
  }

  String reverseString(String input) {
    final CString inputCString = input.toNativeUtf8();
    final CString result = _reverseString(inputCString);
    _freeString(inputCString);
    final String resultDart = result.toDartString();
    _freeString(result);
    return resultDart;
  }

  double calculate(double a, double b, CalculationOperation operation) {
    final request = calloc<CalculationRequest>();
    final ref = request.ref;
    ref
      ..a = a
      ..b = b
      ..operation = operation.index;
    final result = _calculate(ref);
    return result;
  }
}
