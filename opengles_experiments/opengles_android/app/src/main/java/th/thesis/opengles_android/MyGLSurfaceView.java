package th.thesis.opengles_android;

import android.content.Context;
import android.opengl.GLSurfaceView;

public class MyGLSurfaceView extends GLSurfaceView {

    private final MyGLSurfaceViewRenderer renderer;

    public MyGLSurfaceView(Context context){
        super(context);
        setEGLContextClientVersion(2);
        renderer = new MyGLSurfaceViewRenderer();
        setRenderer(renderer);
    }
}
