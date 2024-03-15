import 'package:flutter/material.dart';
import 'package:flutter_experiments/components/experiment_card.dart';
import 'package:flutter_experiments/experiments/platform_channel/platform_channel_provider.dart';
import 'package:platform_plugin/platform_plugin.dart';
import 'package:provider/provider.dart';

class PlatformChannelBatteryCard extends StatelessWidget {
  const PlatformChannelBatteryCard({super.key});
  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Platform Channel Battery Experiment',
      icon: const Icon(Icons.battery_std),
      description:
          'This experiment uses a platform channel to get the battery level of the device.',
      child: _PlatformChannelBatteryExperiment(),
    );
  }
}

class _PlatformChannelBatteryExperiment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlatformChannelProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            const Text('The battery level is displayed below.'),
            const SizedBox(
              height: 8,
            ),
            Text(
              context.watch<PlatformChannelProvider>().batteryLevel,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Get Battery Level'),
                  onPressed: () {
                    context.read<PlatformChannelProvider>().getBatteryLevel();
                  },
                ),
                ElevatedButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    context.read<PlatformChannelProvider>().resetBatteryLevel();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PlatformChannelAndroidVersionCard extends StatelessWidget {
  const PlatformChannelAndroidVersionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExperimentCard(
      title: 'Platform Plugin Experiment',
      icon: const Icon(Icons.android),
      description:
          'This experiment uses a platform plugin to get the Android version of the device.',
      child: FutureBuilder<String?>(
        future: PlatformPlugin().getPlatformVersion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const Text('The Android version is displayed below.'),
                const SizedBox(
                  height: 8,
                ),
                if (snapshot.hasError)
                  Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                if (snapshot.hasData)
                  Text(
                    snapshot.data ?? '',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
