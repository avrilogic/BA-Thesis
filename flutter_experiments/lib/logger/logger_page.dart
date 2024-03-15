import 'package:flutter/material.dart';
import 'package:flutter_experiments/logger/logger_view.dart';

class LoggerPage extends StatelessWidget {
  const LoggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logger'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: LoggerActions(
              showViewAllButton: false,
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(getLogTiles(context))),
        ],
      ),
    );
  }
}
