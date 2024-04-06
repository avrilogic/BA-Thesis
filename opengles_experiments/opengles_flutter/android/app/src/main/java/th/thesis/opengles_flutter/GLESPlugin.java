package th.thesis.opengles_flutter;

import android.graphics.SurfaceTexture;
import android.util.LongSparseArray;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.view.TextureRegistry;
import th.thesis.opengles_flutter.renderer.MyGLRendererWorker;

public class GLESPlugin implements PigeonInterface.OpenGLESRenderPlugin, FlutterPlugin {
    private TextureRegistry textureRegistry;
    private LongSparseArray<OpenGLRenderer> renders = new LongSparseArray<>();

    @Override
    public void createTexture(@NonNull Long width, @NonNull Long height, @NonNull PigeonInterface.Result<Long> result) {
        // Create new SurfaceTexture
        TextureRegistry.SurfaceTextureEntry newEntry = textureRegistry.createSurfaceTexture();
        SurfaceTexture surface = newEntry.surfaceTexture();
        // Set initial dimensions
        surface.setDefaultBufferSize(width.intValue(), height.intValue());
        MyGLRendererWorker worker = new MyGLRendererWorker();
        OpenGLRenderer render = new OpenGLRenderer(surface, worker, width.intValue(), height.intValue());
        renders.put(newEntry.id(), render);
        result.success(newEntry.id());
    }

    @Override
    public void updateTexture(@NonNull Long textureId, @NonNull Long width, @NonNull Long height, @NonNull PigeonInterface.VoidResult result) {
        OpenGLRenderer render = renders.get(textureId);
        render.onDimensionsChanged(width.intValue(),height.intValue());
        result.success();
    }

    @Override
    public void disposeTexture(@NonNull Long textureId, @NonNull PigeonInterface.VoidResult result) {
        OpenGLRenderer render = renders.get(textureId);
        render.onDispose();
        renders.delete(textureId);
        result.success();
    }

    @NonNull
    @Override
    public Long getFps(@NonNull Long textureId) {
        OpenGLRenderer render = renders.get(textureId);
        return (long) render.getFps();
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        this.textureRegistry = binding.getTextureRegistry();
        PigeonInterface.OpenGLESRenderPlugin.setUp(binding.getBinaryMessenger(),this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        PigeonInterface.OpenGLESRenderPlugin.setUp(binding.getBinaryMessenger(), null);
    }
}
