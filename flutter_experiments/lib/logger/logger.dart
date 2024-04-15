import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

final class Logger extends ChangeNotifier {
  static final Logger _instance = Logger._internal();
  factory Logger() => _instance;

  Logger._internal();

  final List<LogEvent> _logs = [];
  List<LogEvent> get logs => _logs;
  String get logsAsString => _logsToString(_logs);

  static void addLogEvent(LogEvent log) {
    _instance._logs.add(log);
    _instance.notifyListeners();
    if (log.level == LogLevel.error || log.level == LogLevel.warning) {
      Fluttertoast.showToast(
          msg: log.toString(),
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // ignore: avoid_print
    print(log.toString());
  }

  static void add(LogLevel level, String message) =>
      addLogEvent(LogEvent(message, DateTime.now(), level));

  static void error(String message) => add(LogLevel.error, message);

  static void warning(String message) => add(LogLevel.warning, message);

  static void debug(String message) => add(LogLevel.debug, message);

  static void info(String message) => add(LogLevel.info, message);

  static void clearLogs() {
    _instance._logs.clear();
    _instance.notifyListeners();
  }

  static Future<bool> exportLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filepath = '${directory.path}/logs/log-${DateTime.now()}.txt';
      Logger.debug('Exporting logs to $filepath');
      await directory.create(recursive: true);
      final f = File(filepath);
      await f.create(recursive: true);
      await f.writeAsString(_logsToString(_instance._logs));
      return f.exists();
    } catch (e) {
      Logger.error('Failed to export logs: $e');
      return Future.value(false);
    }
  }
}

class LogEvent {
  final String message;
  final DateTime time;
  final LogLevel level;

  LogEvent(this.message, this.time, this.level);

  @override
  String toString() {
    return '[${time.toIso8601String()} ${getLogLevelString(level)}]: $message';
  }
}

enum LogLevel {
  undefined,
  info,
  debug,
  warning,
  error,
}

String getLogLevelString(LogLevel level) {
  switch (level) {
    case LogLevel.info:
      return 'Info';
    case LogLevel.warning:
      return 'Warning';
    case LogLevel.error:
      return 'Error';
    case LogLevel.debug:
      return 'Debug';
    default:
      return 'Unknown';
  }
}

String _logsToString(List<LogEvent> logs) {
  StringBuffer sb = StringBuffer();
  for (var log in logs) {
    sb.write(log.toString());
    sb.write('\n');
  }
  return sb.toString();
}
