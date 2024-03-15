import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_experiments/logger/logger_view.dart';
import 'package:flutter_experiments/settings/settings_page.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});
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
                icon: Icon(Icons.settings),
                text: 'Settings',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            InfoPage(),
            SettingsPage(),
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
