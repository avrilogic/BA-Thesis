import 'package:flutter/material.dart';
import 'package:flutter_experiments/settings/settings_card.dart';
import 'package:flutter_experiments/settings/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final String title = 'Settings';
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SettingsBasicsCard(),
        const SettingsBenchmarkCard(),
        const SettingsBenchmarkCard(),
        const SettingsBenchmarkCard(),
        const SettingsBenchmarkCard(),
      ],
    );
  }
}

class SettingsBasicsCard extends StatelessWidget {
  const SettingsBasicsCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (
        BuildContext context,
        SettingsProvider controlChangeNotifier,
        Widget? child,
      ) =>
          SettingsCard(
        title: 'Basics',
        icon: Icons.lightbulb,
        state: controlChangeNotifier.state.basics,
        onEnabledChanged: controlChangeNotifier.toggleBasics,
        isCollapsible: false,
        child: Column(
          children: [
            Row(
              children: [
                const Text('Speed'),
                Expanded(
                  child: Slider(
                    value: controlChangeNotifier.state.basics.value,
                    onChanged: (value) {
                      controlChangeNotifier.updateState((state) =>
                          state.copyWith(
                              basics: state.basics.copyWith(value: value)));
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 20), // Add a SizedBox
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Channel Name'),
                TextField(
                  onChanged: (value) {
                    controlChangeNotifier.updateState(
                      (state) => state.copyWith(
                        basics: state.basics.copyWith(name: value),
                      ),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingsBenchmarkCard extends StatelessWidget {
  const SettingsBenchmarkCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (
        BuildContext context,
        SettingsProvider controlChangeNotifier,
        Widget? child,
      ) =>
          SettingsCard(
        title: 'Benchmark',
        icon: Icons.speed,
        state: controlChangeNotifier.state.channels,
        onEnabledChanged: controlChangeNotifier.toggleChannels,
        child: Column(
          children: [
            Row(
              children: [
                const Text('Temperatur'),
                Slider(
                  value: 0.5,
                  onChanged: (value) {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
