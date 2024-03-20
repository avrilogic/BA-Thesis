import 'package:flutter/material.dart';
import 'package:opengles_flutter/open_gl_platform_view.dart';
import 'package:opengles_flutter/pigeon_interface.g.dart';

class OpenGlPlatformViewPage extends StatelessWidget {
  const OpenGlPlatformViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenGL Platform View'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Column(children: [
            Expanded(child: OpenGlPlatformView()),
            OpenGlPlatformViewFps()
          ]),
        ),
      ),
    );
  }
}

class OpenGlPlatformViewFps extends StatelessWidget {
  OpenGlPlatformViewFps({super.key});
  final controller = OpenGLPlatformViewControl();

  @override
  Widget build(BuildContext context) {
    final fpsStream =
        Stream.periodic(const Duration(seconds: 1)).asyncMap((event) {
      final value = controller.getFps();
      return value;
    });

    return StreamBuilder<int>(
      stream: fpsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('FPS: ${snapshot.data}');
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
