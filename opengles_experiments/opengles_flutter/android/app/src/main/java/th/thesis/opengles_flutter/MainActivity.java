package th.thesis.opengles_flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {

  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
    flutterEngine.getPlugins().add(new GLESPlugin());
    flutterEngine.getPlugins().add(new OpenGLPlatformView.OpenGLPlatformViewPlugin());
    flutterEngine.getPlatformViewsController()
            .getRegistry()
            .registerViewFactory("OpenGlPlatformView", new OpenGLPlatformView.Factory());
  }
}
