package th.thesis.opengles_flutter;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.view.SurfaceView;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import java.util.Map;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import th.thesis.opengles_flutter.renderer.MyGLRendererWorker;

public class OpenglPlatformView implements PlatformView {
    @NonNull
    private final OpenglPlatformViewSurfaceView view;
    public static FPSCounter fpsCounter = new FPSCounter();

    private OpenglPlatformView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        view = new OpenglPlatformViewSurfaceView(context);
    }

    @Nullable
    @Override
    public View getView() {
        return view;
    }

    @Override
    public void dispose() {
    }

    public static class Factory extends PlatformViewFactory {
        Factory() {
            super(StandardMessageCodec.INSTANCE);
        }
        @NonNull
        @Override
        public PlatformView create(Context context, int viewId, @Nullable Object args) {
            final Map<String, Object> creationParams = (Map<String, Object>) args;
            return new OpenglPlatformView(context, viewId, creationParams);
        }
    }
    private class OpenglPlatformViewSurfaceView extends GLSurfaceView {
        public OpenglPlatformViewSurfaceView(Context context) {
            super(context);
            setEGLContextClientVersion(2);
            setRenderer(new OpenglPlatformViewSurfaceViewRenderer());
        }

        private class OpenglPlatformViewSurfaceViewRenderer implements GLSurfaceView.Renderer{

            private MyGLRendererWorker worker = new MyGLRendererWorker();
            @Override
            public void onSurfaceCreated(GL10 gl, EGLConfig config) {
                worker.onCreate();
            }

            @Override
            public void onSurfaceChanged(GL10 gl, int width, int height) {
                worker.onDimensionChanged(width, height);
            }

            @Override
            public void onDrawFrame(GL10 gl) {
                worker.onDraw();
                fpsCounter.logFrame();
            }
        }
    }

    public static class OpenGLPlatformViewPlugin implements PigeonInterface.OpenGLPlatformViewControl, FlutterPlugin {

        @Override
        public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
            PigeonInterface.OpenGLPlatformViewControl.setUp(binding.getBinaryMessenger(), this);
        }

        @Override
        public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
            PigeonInterface.OpenGLPlatformViewControl.setUp(binding.getBinaryMessenger(), null);
        }

        @NonNull
        @Override
        public Long getFps() {
            return (long) fpsCounter.getFps();
        }
    }

}
