import 'package:flutter/material.dart';
import 'package:flutter_experiments/experiments/ffi_simple_test_plugin/ffi_simple_test_plugin_page.dart';
import 'package:flutter_experiments/experiments/method_channel_jni_test_plugin/method_channel_jni_test_plugin_page.dart';
import 'package:flutter_experiments/experiments/ffi_precompiled_lib_test_plugin/ffi_precompiled_lib_test_plugin_page.dart';
import 'package:flutter_experiments/experiments/ffigen_test_plugin/ffigen_test_plugin_page.dart';
import 'package:flutter_experiments/home_page.dart';
import 'package:flutter_experiments/logger/logger_page.dart';
import 'package:flutter_experiments/extras_page.dart';
import 'package:flutter_experiments/experiments/pigeon_platform_channel/pigeon_page.dart';
import 'package:flutter_experiments/experiments/platform_channel/platform_channel_page.dart';

class ExperimentMenuEntry {
  const ExperimentMenuEntry(this.title, this.icon, this.route, this.builder);

  final String title;
  final IconData icon;
  final String route;

  final StatelessWidget Function(BuildContext) builder;
}

final List<ExperimentMenuEntry> menuEntries = [
  ExperimentMenuEntry(
    'Platform Channel',
    Icons.android,
    '/experiments/platform_channel',
    (context) => const PlatformChannelPage(),
  ),
  ExperimentMenuEntry(
    'Pigeon',
    Icons.pets,
    '/experiments/pigeon',
    (context) => const PigeonPage(),
  ),
  ExperimentMenuEntry(
    'MethodChannel Jni Test',
    Icons.code,
    '/experiments/method_channel_jni_test_plugin',
    (context) => const MethodChannelJniTestPluginPage(),
  ),
  ExperimentMenuEntry(
    'FFI Simple Test',
    Icons.code,
    '/experiments/ffi_simple_test_plugin',
    (context) => const FFISimpleTestPluginPage(),
  ),
  ExperimentMenuEntry(
    'FFI Gen Test',
    Icons.code,
    '/experiments/ffigen_test_plugin',
    (context) => const FFIGenTestPluginPage(),
  ),
  ExperimentMenuEntry(
    'FFI Precompiled Lib Test',
    Icons.code,
    '/experiments/ffi_precompiled_lib_test_plugin',
    (context) => const FFIPrecompiledLibTestPluginPage(),
  ),
];

final routes = {
  '/': (BuildContext context) => const HomePage(),
  '/options': (BuildContext context) => const ExtrasPage(),
  '/options/info/logger': (BuildContext context) => const LoggerPage(),
  for (var entry in menuEntries) entry.route: entry.builder,
};
