import 'package:sideload_server/sideload_server.dart' as sideload_server;

void main(List<String> arguments) {
  print('SideLoad Server started.');
  final port = arguments.isEmpty ? 8080 : int.parse(arguments.first);
  sideload_server.run(port);

  print('Server running on port $port');
  print('Available on:');
  sideload_server.getIPsV4().then((ips) {
    for (var ip in ips) {
      print('  http://$ip:$port');
    }
    sideload_server.writeConnections(ips, port,
        '../packages/ffi_precompiled_lib_test_plugin/lib/connections.dart');
  });
}
