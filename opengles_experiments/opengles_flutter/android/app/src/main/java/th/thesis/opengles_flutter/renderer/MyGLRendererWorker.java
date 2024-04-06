package th.thesis.opengles_flutter.renderer;

import android.opengl.GLES20;
import android.util.Log;


import th.thesis.opengles_flutter.OpenGLRenderer;

public class MyGLRendererWorker implements OpenGLRenderer.Worker {
    private Square mSquare;
    boolean flip = false;

    public static int loadShader(int type, String shaderCode) {

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

    // Called once to set up the view's OpenGL ES environment.
    @Override
    public void onCreate() {
        // Set the background frame color
        GLES20.glClearColor(0.0f, 50.0f, 0.0f, 1.0f);
        mSquare = new Square();
    }

    // Called if the geometry of the view changes,
    // for example when the device's screen orientation changes.
    @Override
    public boolean onDraw() {
        // Redraw background color
        float[] color = flip ? ColorPalette.blue() : ColorPalette.violet();
        GLES20.glClearColor(color[0], color[1], color[2], color[3]);
        GLES20.glClear(GLES20.GL_COLOR_BUFFER_BIT);
        mSquare.draw();
        flip = !flip;
        return true;
    }

    @Override
    public void onDispose() {

    }

    @Override
    public void onDimensionChanged(int width, int height) {

    }
}

