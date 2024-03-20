package th.thesis.opengles_android;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.ConfigurationInfo;
import android.opengl.GLSurfaceView;
import android.os.Bundle;
import android.util.Log;

public class TextureActivity extends Activity {
    private MyGLTextureView gLView;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Create a GLSurfaceView instance and set it
        // as the ContentView for this Activity.
        gLView = new MyGLTextureView(this);
        gLView.setRenderer(new MyGLRenderer());
        if (detectOpenGLES20()) {
            setContentView(gLView);
        }
        else {
            Log.e(this.getLocalClassName(), "OpenGL ES 2 not available");
        }
    }
    private boolean detectOpenGLES20() {
        ActivityManager am =
                (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        ConfigurationInfo info = am.getDeviceConfigurationInfo();
        return (info.reqGlEsVersion >= 0x20000);
    }

}
