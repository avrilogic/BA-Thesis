import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:opengles_flutter/flutter_fps.dart';
import 'package:opengles_flutter/pigeon_interface.g.dart';

class OpenGlTexture extends StatefulWidget {
  OpenGlTexture({super.key});
  final OpenGLESRenderPlugin controller = OpenGLESRenderPlugin();
  @override
  _OpenGlTextureState createState() => _OpenGlTextureState();
}

class _OpenGlTextureState extends State<OpenGlTexture> {
  int? _textureId;
  Size? _size;
  Stream<int>? _fpsStream;
  @override
  Widget build(BuildContext context) {
    final currentSize = MediaQuery.of(context).size;
    init(currentSize);

    _fpsStream = Stream.periodic(const Duration(seconds: 1)).asyncMap((event) {
      if (_textureId == null) return Future.value(0);
      final value = widget.controller.getFps(_textureId!);
      return value;
    });
    //_fpsStream = Stream.empty();
    return _textureId != null
        ? Column(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
              child: Texture(textureId: _textureId!),
            ),
            FlutterFps(onFpsSignal: (fps) {
              final timestamp = DateTime.now().toIso8601String();
              debugPrint('Flutter_FPS: $timestamp: $fps');
            }),
            StreamBuilder<int>(
              stream: _fpsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final timestamp = DateTime.now().toIso8601String();
                  debugPrint('Render_FPS: $timestamp: ${snapshot.data}');
                  return Text('Render_FPS: ${snapshot.data}');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ])
        : const SizedBox.shrink();
  }

  void init(Size size) async {
    final width = size.width.ceil();
    final height = size.height.ceil();
    if (_textureId == null) {
      final textureId = await widget.controller.createTexture(width, height);
      debugPrint('textureId: $textureId');
      setState(() {
        _textureId = textureId;
        _size = size;
      });
    } else {
      if (_size != size) {
        debugPrint('currentSize: $size');
        await widget.controller.updateTexture(_textureId!, width, height);
        debugPrint('updateTexture: $_textureId');
        setState(() {
          _size = size;
        });
      }
    }
  }

  @override
  dispose() {
    if (_textureId != null) {
      widget.controller.disposeTexture(_textureId!);
      _textureId = null;
    }
    super.dispose();
  }
}
