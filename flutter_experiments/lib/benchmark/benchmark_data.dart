class BenchmarkData {
  DateTime? startTime;
  DateTime? endTime;
  Duration get duration => endTime!.difference(startTime!);
}

class BenchmarkTask {
  final BenchmarkType type;
  final int bytes;
  final int iterations;
  final List<BenchmarkData> data = [];
  BenchmarkStatus status = BenchmarkStatus.notStarted;
  BenchmarkTask({
    required this.type,
    required this.bytes,
    required this.iterations,
  });

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln(
        'BenchmarkTask(type: $type, bytes: $bytes, iterations: $iterations),');
    buffer.writeln('Status: ${status.name}');
    if (status == BenchmarkStatus.completed) {
      buffer.writeln('status: $status.name, results: ${results()}');
    } else {
      buffer.writeln('status: $status.name');
    }
    return buffer.toString();
  }

  String results() {
    return 'Average duration: ${data.averageDuration.inMicroseconds} microseconds';
  }
}

enum BenchmarkType {
  ffi,
  platformChannel,
  platformChannelJNI,
}

enum BenchmarkStatus {
  notStarted,
  running,
  completed,
  failed,
}

extension BenchmarkStatusExtension on BenchmarkStatus {
  String get name {
    switch (this) {
      case BenchmarkStatus.notStarted:
        return 'Not Started';
      case BenchmarkStatus.running:
        return 'Running';
      case BenchmarkStatus.completed:
        return 'Completed';
      case BenchmarkStatus.failed:
        return 'Failed';
    }
  }
}

extension BenchmarkDataListExt on List<BenchmarkData> {
  Duration get averageDuration {
    final totalDuration = fold<Duration>(
      Duration.zero,
      (previousValue, element) => previousValue + element.duration,
    );
    return totalDuration ~/ length;
  }
}
