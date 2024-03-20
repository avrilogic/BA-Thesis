import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeon_interface.g.dart',
  dartOptions: DartOptions(),
  javaOut:
      'android/app/src/main/java/th/thesis/opengles_flutter/PigeonInterface.java',
  javaOptions: JavaOptions(
    package: 'th.thesis.opengles_flutter',
    className: 'PigeonInterface',
  ),
))
@HostApi()
abstract class OpenGLESRenderPlugin {
  @async
  int createTexture(int width, int height);

  @async
  void updateTexture(int textureId, int width, int height);

  @async
  void disposeTexture(int textureId);

  int getFps(int textureId);
}
