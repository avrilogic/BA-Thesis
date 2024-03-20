import 'package:flutter/material.dart';
import 'package:opengles_flutter/open_gl_texture.dart';

class OpenGLTexturePage extends StatelessWidget {
  const OpenGLTexturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenGL Texture'),
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
          child: OpenGlTexture(),
        ),
      ),
    );
  }
}
