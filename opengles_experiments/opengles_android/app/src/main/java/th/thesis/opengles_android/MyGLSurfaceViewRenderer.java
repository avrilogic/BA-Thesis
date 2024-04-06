package th.thesis.opengles_android;

import android.opengl.GLES20;
import android.opengl.GLSurfaceView;
import android.util.Log;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class MyGLSurfaceViewRenderer implements GLSurfaceView.Renderer {
    private Square mSquare;

    // Called once to set up the view's OpenGL ES environment.
    @Override
    public void onSurfaceCreated(GL10 gl, EGLConfig config) {
        // Set the background frame color
        GLES20.glClearColor(0.0f, 50.0f, 0.0f, 1.0f);
        mSquare = new Square();
    }


    // Called if the geometry of the view changes,
    // for example when the device's screen orientation changes.
    @Override
    public void onSurfaceChanged(GL10 gl, int width, int height) {
        GLES20.glViewport(0,0,width,height);
    }

    // Called for each redraw of the view.
    @Override
    public void onDrawFrame(GL10 gl) {
        // Redraw background color
        float[] color = ColorPalette.blue();
        GLES20.glClearColor(color[0],color[1],color[2], color[3]);
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        mSquare.draw();
    }

    public static int loadShader(int type, String shaderCode){

        // create a vertex shader type (GLES20.GL_VERTEX_SHADER)
        // or a fragment shader type (GLES20.GL_FRAGMENT_SHADER)
        int shader = GLES20.glCreateShader(type);

        // add the source code to the shader and compile it
        GLES20.glShaderSource(shader, shaderCode);
        GLES20.glCompileShader(shader);

        return shader;
    }
    public static void checkGlError(String glOperation) {
        int error;
        while ((error = GLES20.glGetError()) != GLES20.GL_NO_ERROR) {
            Log.e("MyGLRenderer", glOperation + ": glError " + error);
            throw new RuntimeException(glOperation + ": glError " + error);
        }
    }
}

