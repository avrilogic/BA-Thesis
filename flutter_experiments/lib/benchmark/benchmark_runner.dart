
import 'package:ffi_simple_test_plugin/ffi_bridge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_experiments/benchmark/benchmark_data.dart';
import 'package:flutter_experiments/experiments/pigeon_platform_channel/messages.g.dart';
import 'package:flutter_experiments/logger/logger.dart';
import 'package:method_channel_jni_test_plugin/method_channel_jni_test_plugin.dart';

final _ffiBridge = FFIBridge();
final MethodChannelPigeon _platformChannelPigeon = MethodChannelPigeon();
final MethodChannelJniTestPlugin _methodChannelJniTestPlugin =
    MethodChannelJniTestPlugin();

class BenchmarkRunner extends ChangeNotifier {
  final List<BenchmarkTask> benchmarks = [];
  int _current = 0;
  bool _running = false;

  BenchmarkRunner();

  int get length => benchmarks.length;
  void addBenchmark(BenchmarkTask task) {
    benchmarks.add(task);
    notifyListeners();
  }

  void removeBenchmark(BenchmarkTask task) {
    benchmarks.remove(task);
    notifyListeners();
  }

  void clearBenchmarks() {
    benchmarks.clear();
    notifyListeners();
  }

  int get current => _current;
  Future<void> run() async {
    Logger.debug('Running benchmarks with ${benchmarks.length} tasks');
    _current = 0;
    for (final benchmark in benchmarks) {
      _current++;
      benchmark.status = BenchmarkStatus.running;
      notifyListeners();
      try {
        await _runTask(benchmark);
        benchmark.status = BenchmarkStatus.completed;
        Logger.debug(
            'Completed Benchmark:\t${benchmark.type.name},\t${benchmark.bytes} bytes,\t${benchmark.iterations} iterations,\t${benchmark.data.averageDuration.inMicroseconds} microseconds');
      } catch (e) {
        benchmark.status = BenchmarkStatus.failed;
        Logger.error('Failed to run benchmark: $e');
      }
      notifyListeners();
    }
  }

  void stop() {
    _running = false;
  }

  Future<void> _runTask(BenchmarkTask task) async {
    void Function(List<BenchmarkData> data)? runner;
    switch (task.type) {
      case BenchmarkType.ffi:
        runner = (data) => data.add(_runFFITask(generateBytes(task.bytes)));
        break;
      case BenchmarkType.platformChannel:
        runner = (data) =>
            data.add(_runPlatformChannelTask(generateBytes(task.bytes)));
        break;
      case BenchmarkType.platformChannelJNI:
        runner = (data) =>
            data.add(_runPlatformChannelJNITask(generateBytes(task.bytes)));
        break;
      default:
        throw UnimplementedError('Benchmark type not implemented');
    }

    for (var i = 0; i < task.iterations; i++) {
      runner(task.data);
      if (i % 100 == 0) {
        Logger.debug('Iteration $i of ${task.iterations} complete');
      }
    }
  }
}

Uint8List generateBytes(int bytes) {
  final list = Uint8List(bytes);
  for (var i = 0; i < bytes; i++) {
    list[i] = i % 256;
  }
  return list;
}

BenchmarkData _runFFITask(Uint8List data) {
  BenchmarkData result = BenchmarkData()..startTime = DateTime.now();
  _ffiBridge.benchmark(data);
  result.endTime = DateTime.now();
  return result;
}

BenchmarkData _runPlatformChannelTask(Uint8List data) {
  BenchmarkData result = BenchmarkData()..startTime = DateTime.now();
  _platformChannelPigeon.benchmark(data);
  result.endTime = DateTime.now();
  return result;
}

BenchmarkData _runPlatformChannelJNITask(Uint8List data) {
  BenchmarkData result = BenchmarkData()..startTime = DateTime.now();
  _methodChannelJniTestPlugin.benchmark(data);
  result.endTime = DateTime.now();
  return result;
}
