import 'package:flutter/material.dart';
import 'package:flutter_experiments/settings/settings_state.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.title,
    required this.child,
    this.icon = Icons.lightbulb,
    required this.state,
    required this.onEnabledChanged,
    this.isCollapsible = true,
  });
  final String title;
  final Widget child;
  final IconData icon;
  final SettingsGroupStateBase state;
  final void Function(bool?) onEnabledChanged;
  final bool isCollapsible;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                if (isCollapsible)
                  Switch(
                    value: state.isEnabled,
                    onChanged: onEnabledChanged,
                  )
              ],
            ),
            if (state.isEnabled || !isCollapsible)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: child,
              ),
          ],
        ),
      ),
    );
  }
}
