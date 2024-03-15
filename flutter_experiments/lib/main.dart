import 'package:flutter/material.dart';
import 'package:flutter_experiments/logger/logger.dart';
import 'package:flutter_experiments/experiments/platform_channel/platform_channel_provider.dart';
import 'package:flutter_experiments/routes.dart';
import 'package:flutter_experiments/settings/settings_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.debug('Starting app');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger.debug('Building app');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(create: (context) => PlatformChannelProvider()),
        ChangeNotifierProvider(create: (context) => Logger()),
      ],
      child: MaterialApp(
        title: 'Flutter Experiment',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: routes,
      ),
    );
  }
}
