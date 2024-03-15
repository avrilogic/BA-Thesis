import 'package:flutter/material.dart';

class ExperimentCard extends StatelessWidget {
  const ExperimentCard({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    this.icon,
  });
  final String title;
  final String description;
  final Widget child;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: icon,
            title: Text(title),
            subtitle: Text(description),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
