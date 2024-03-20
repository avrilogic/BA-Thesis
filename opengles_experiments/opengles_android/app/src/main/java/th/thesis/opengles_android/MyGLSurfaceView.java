package th.thesis.opengles_android;

import android.content.Context;
import android.opengl.GLSurfaceView;
import android.view.View;

public class MyGLSurfaceView extends GLSurfaceView {

    private final MyGLRenderer renderer;

    public MyGLSurfaceView(Context context){
        super(context);
        setEGLContextClientVersion(2);
        renderer = new MyGLRenderer();
        setRenderer(renderer);
    }

}
