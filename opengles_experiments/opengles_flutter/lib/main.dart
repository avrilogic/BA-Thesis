import 'package:flutter/material.dart';
import 'package:opengles_flutter/open_gl_platform_view_page.dart';
import 'package:opengles_flutter/open_gl_texture.dart';
import 'package:opengles_flutter/open_gl_texture_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter OpenGL Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'This application demonstrates the use of OpenGL in Flutter. ',
              ),
            ),
          ),
          ListTile(
            title: const Text('OpenGL Texture'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OpenGLTexturePage()),
              );
            },
          ),
          ListTile(
            title: const Text('OpenGL Platform View'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OpenGlPlatformViewPage()),
              );
            },
          ),
        ],
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
