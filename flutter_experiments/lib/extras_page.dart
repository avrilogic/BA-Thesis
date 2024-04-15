import 'package:flutter/material.dart';
import 'package:flutter_experiments/benchmark/benchmark_tab.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_experiments/logger/logger_view.dart';

class ExtrasPage extends StatelessWidget {
  const ExtrasPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Options'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.dashboard),
                text: 'Info',
              ),
              Tab(
                icon: Icon(Icons.speed),
                text: 'Benchmark',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const InfoPage(),
            BenchmarkTab(),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        _AppInfos(),
        LoggerPreview(),
      ],
    );
  }
}

class _AppInfos extends StatelessWidget {
  const _AppInfos();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'App Infos',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                ListTile(
                  title: const Text('App name'),
                  subtitle: Text(snapshot.data?.appName ?? 'unknown'),
                ),
                ListTile(
                  title: const Text('Package name'),
                  subtitle: Text(snapshot.data?.packageName ?? 'unknown'),
                ),
                ListTile(
                  title: const Text('App Version'),
                  subtitle: Text(snapshot.data?.version ?? 'unknown'),
                ),
                ListTile(
                  title: const Text('Build Number'),
                  subtitle: Text(snapshot.data?.buildNumber ?? 'unknown'),
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

Widget extrasButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.pushNamed(context, '/options');
    },
    tooltip: 'Extras',
    child: const Icon(Icons.more_horiz),
  );
}
