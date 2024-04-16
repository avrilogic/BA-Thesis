import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef CString = Pointer<Utf8>;

enum CalculationOperation { add, subtract, multiply, divide }

final class CalculationRequest extends Struct {
  @Double()
  external double a;

  @Double()
  external double b;

  @Int32()
  external int operation;
}

// Hello World function
typedef HelloWorld = CString Function();
typedef HelloWorldNative = CString Function();

// Reverse string function
typedef ReverseString = CString Function(CString);
typedef ReverseStringNative = CString Function(CString);

// Free string function
typedef FreeString = void Function(CString);
typedef FreeStringNative = Void Function(CString);

// Calculation function
typedef Calculate = double Function(CalculationRequest);
typedef CalculateNative = Double Function(CalculationRequest);

// Create CalculationRequest
typedef CreateCalculationRequest = CalculationRequest Function(
    double, double, int);
typedef CreateCalculationRequestNative = CalculationRequest Function(
    Double, Double, Int32);

// Define the type for the C function.
typedef CBenchmark = Void Function(Pointer<Uint8>, Int32);
typedef DartBenchmark = void Function(Pointer<Uint8>, int);
