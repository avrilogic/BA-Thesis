import 'package:flutter/material.dart';
import 'package:flutter_experiments/logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoggerPreview extends StatelessWidget {
  const LoggerPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Logger',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const LoggerActions(),
          ...getLogTiles(context, limit: 3),
        ],
      ),
    );
  }
}

class LoggerActions extends StatelessWidget {
  const LoggerActions({super.key, this.showViewAllButton = true});

  final bool showViewAllButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (showViewAllButton)
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/options/info/logger');
            },
            child: const Text('View all'),
          ),
        ElevatedButton(
          onPressed: () {
            Logger.clearLogs();
          },
          child: const Text('Clear'),
        ),
        ElevatedButton(
            onPressed: () async {
              Logger.exportLogs().then(
                (value) => Fluttertoast.showToast(
                    msg: value ? 'Logs Exported' : 'Logs export Failed'),
              );
            },
            child: const Text('Export'))
      ],
    );
  }
}

List<Widget> getLogTiles(BuildContext context, {int limit = 0}) {
  var logs = context.watch<Logger>().logs;
  if (logs.isEmpty) {
    return const [Text('No logs', style: TextStyle(color: Colors.grey))];
  }
  int length = logs.length;
  if (limit != 0 && length > limit) {
    logs = logs.sublist(length - limit, length);
  }

  return [
    ...logs.map((log) {
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(getLogLevelString(log.level)),
            Text(log.time.toString(), style: const TextStyle(fontSize: 10)),
          ],
        ),
        leading: _getLogLevelIcon(log.level),
        subtitle: Text(log.message),
      );
    }),
    if (limit != 0 && length > limit)
      Container(
        alignment: Alignment.center,
        child: Text(
          '... ${length - limit} more entries',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
  ].toList();
}

Icon _getLogLevelIcon(LogLevel level) {
  switch (level) {
    case LogLevel.info:
      return const Icon(Icons.info);
    case LogLevel.warning:
      return const Icon(Icons.warning);
    case LogLevel.error:
      return const Icon(Icons.error);
    case LogLevel.debug:
      return const Icon(Icons.bug_report);
    default:
      return const Icon(Icons.help);
  }
}
