import 'package:flutter/material.dart';
import 'package:flutter_experiments/extras_page.dart';
import 'package:flutter_experiments/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experimente'),
      ),
      body: ListView(
        children: menuEntries.toTiles(),
      ),
      floatingActionButton: extrasButton(context),
    );
  }
}

class ExperimentTile extends StatelessWidget {
  const ExperimentTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.route,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: () {
        onTap?.call();
        if (route != null) Navigator.pushNamed(context, route!);
      },
    );
  }
}

extension on List<ExperimentMenuEntry> {
  List<Widget> toTiles() {
    return map(
      (entry) => ExperimentTile(
        title: entry.title,
        icon: entry.icon,
        route: entry.route,
      ),
    ).toList();
  }
}
