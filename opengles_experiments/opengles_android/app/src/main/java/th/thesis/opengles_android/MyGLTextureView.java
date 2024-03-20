package th.thesis.opengles_android;


import android.content.Context;
import android.graphics.SurfaceTexture;
import android.opengl.GLSurfaceView;
import android.util.AttributeSet;
import android.opengl.GLUtils;
import android.util.Log;
import android.view.MotionEvent;
import android.view.TextureView;

import androidx.annotation.NonNull;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;
import javax.microedition.khronos.opengles.GL;
import javax.microedition.khronos.opengles.GL10;

public class MyGLTextureView extends TextureView implements TextureView.SurfaceTextureListener {
    private static String TAG = "MyGLTextureView";
    private GLSurfaceView.Renderer renderer;
    private GLThread glThread;

    public MyGLTextureView(@NonNull Context context) {
        this(context, null);
    }

    public MyGLTextureView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public MyGLTextureView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        setSurfaceTextureListener(this);
    }

    @Override
    public void onSurfaceTextureAvailable(@NonNull SurfaceTexture surface, int width, int height) {
        glThread = new GLThread(surface);
        glThread.start();
        Log.i(TAG, "GLThread created and Started");
    }

    @Override
    public void onSurfaceTextureSizeChanged(@NonNull SurfaceTexture surface, int width, int height) {
        glThread.onWindowResize(width, height);
    }

    @Override
    public boolean onSurfaceTextureDestroyed(@NonNull SurfaceTexture surface) {
        glThread.requestExitAndWait();
        return false;
    }

    @Override
    public void onSurfaceTextureUpdated(@NonNull SurfaceTexture surface) {

    }

    public void setRenderer(GLSurfaceView.Renderer renderer) {
        this.renderer = renderer;
    }


    private class GLThread extends Thread {
        final static int EGL_OPENGL_ES2_BIT = 4;
        private volatile boolean finished;
        private final SurfaceTexture surface;

        private EGL10 egl;
        private EGLConfig eglConfig;
        private EGLDisplay eglDisplay;
        private EGLContext eglContext;
        private EGLSurface eglSurface;
        private GL gl;
        private int width = getWidth();
        private int height = getHeight();
        private volatile boolean sizeChanged = true;
        private boolean mExited;
        private boolean mShouldExit;
        private long lastRender;

        GLThread(SurfaceTexture surface) {
            this.surface = surface;
        }

        @Override
        public void run() {
            initGL();
            GL10 gl10 = (GL10) gl;
            renderer.onSurfaceCreated(gl10, eglConfig);
            while (true) {
                synchronized (sGLThreadManager) {
                    if (mShouldExit) {
                        finishGL();
                        sGLThreadManager.threadExiting(this);
                        return;
                    }
                    checkCurrent();
                    if (sizeChanged) {
                        createSurface();
                        renderer.onSurfaceChanged(gl10, width, height);
                        sizeChanged = false;
                    }

                    renderer.onDrawFrame(gl10);
                    if (!egl.eglSwapBuffers(eglDisplay, eglSurface)) {
                        throw new RuntimeException("Cannot swap buffers");
                    }
                    try {
                        Thread.sleep(50);
                    } catch (InterruptedException e) {
                        throw new RuntimeException(e);
                    }
                }
            }

        }

        private void destroySurface() {

            if (eglSurface != null && eglSurface != EGL10.EGL_NO_SURFACE) {
                // set current to none
                egl.eglMakeCurrent(eglDisplay, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_CONTEXT);
                egl.eglDestroySurface(eglDisplay, eglSurface);
                eglSurface = null;
            }

        }

        public boolean createSurface() {
            if (egl == null) {
                throw new RuntimeException("EGL is not initialized");
            } else if (eglDisplay == null) {
                throw new RuntimeException("EGL Display is not initialized");
            } else if (eglConfig == null) {
                throw new RuntimeException("EGL Config was not set");
            }

            destroySurface();

            try {
                eglSurface = egl.eglCreateWindowSurface(eglDisplay, eglConfig, surface, null);
            } catch (IllegalArgumentException e) {
                // This exception indicates that the surface flinger surface
                // is not valid. This can happen if the surface flinger surface has
                // been torn down, but the application has not yet been
                // notified via SurfaceHolder.Callback.surfaceDestroyed.
                // In theory the application should be notified first,
                // but in practice sometimes it is not. See b/4588890
                Log.e(TAG, "eglCreateWindowSurface", e);
                return false;
            }

            // make the GL context current
            if (!egl.eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
                Log.e(TAG, "Wasn't able to make eglContext current: " + getEglErrorString());
                return false;
            }
            Log.i(TAG, "Surface created");
            return true;

        }

        private void checkCurrent() {
            if (!eglContext.equals(egl.eglGetCurrentContext()) || !eglSurface.equals(egl.eglGetCurrentSurface(EGL10.EGL_DRAW))) {
                checkEglError();
                if (!egl.eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
                    throw new RuntimeException("eglMakeCurrent failed: " + getEglErrorString());
                }
                checkEglError();
            }
        }

        private void checkEglError() {
            final int error = egl.eglGetError();
            if (error != EGL10.EGL_SUCCESS) {
                Log.e(TAG, "eglError detected: " + GLUtils.getEGLErrorString(error));
            }
        }

        private void finishGL() {
            // free up resources
            egl.eglDestroyContext(eglDisplay, eglContext);
            // cut display connection
            egl.eglTerminate(eglDisplay);
            surface.release();
        }

        private void initGL() {
            egl = (EGL10) EGLContext.getEGL();

            eglDisplay = egl.eglGetDisplay(EGL10.EGL_DEFAULT_DISPLAY);
            if (eglDisplay == EGL10.EGL_NO_DISPLAY) {
                throw new RuntimeException("Was not able to retrieve egl display from vit eglGetDisplay");
            }

            // initialize, set major, minor version
            int[] version = new int[2];
            if (!egl.eglInitialize(eglDisplay, version)) {
                throw new RuntimeException("Unable to initialize EGL with eglDisplay: " + getEglErrorString());
            }

            // get config
            eglConfig = chooseConfig();
            if (eglConfig == null) {
                throw new RuntimeException("Was unable to retrieve configuration parameter list");
            }

            // create context
            // set client version to OpenGL ES 2, GL10.EGL_NONE signals the end of the attribute list
            eglContext = createContext(egl,eglDisplay, eglConfig);
            // create Surface
            createSurface();

            if (!egl.eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
                throw new RuntimeException("Was unable to complete setup: " + getEglErrorString());
            }

            gl = eglContext.getGL();
        }


        private EGLContext createContext(EGL10 egl, EGLDisplay eglDisplay, EGLConfig eglConfig) {
            int EGL_CONTEXT_CLIENT_VERSION = 0x3098;
            int[] attribList = {EGL_CONTEXT_CLIENT_VERSION, 2, EGL10.EGL_NONE};
            return egl.eglCreateContext(eglDisplay, eglConfig, EGL10.EGL_NO_CONTEXT, attribList);
        }

        private String getEglErrorString() {
            return GLUtils.getEGLErrorString(egl.eglGetError());
        }

        private EGLConfig chooseConfig() {
            int[] amount = new int[1];
            EGLConfig[] configs = new EGLConfig[1];
            int[] requestsConfigList = getRequestConfigList();
            if (!egl.eglChooseConfig(eglDisplay, requestsConfigList, configs, 1, amount)) {
                throw new RuntimeException("Unable to find best config parameters: " + getEglErrorString());
            } else if (amount[0] > 0) {
                return configs[0];
            }
            return null;
        }

        private int[] getRequestConfigList() {
            return new int[]{
                    EGL10.EGL_RENDERABLE_TYPE, EGL_OPENGL_ES2_BIT,
                    EGL10.EGL_RED_SIZE, 8,
                    EGL10.EGL_GREEN_SIZE, 8,
                    EGL10.EGL_BLUE_SIZE, 8,
                    EGL10.EGL_ALPHA_SIZE, 8,
                    EGL10.EGL_DEPTH_SIZE, 0,
                    EGL10.EGL_STENCIL_SIZE, 0,
                    EGL10.EGL_NONE
            };
        }

        public synchronized void onWindowResize(int w, int h) {
            // locked resources till set
            width = w;
            height = h;
            sizeChanged = true;
        }

        public void requestExitAndWait() {
            // don't call this from GLThread thread or it is a guaranteed
            // deadlock!
            synchronized (sGLThreadManager) {
                mShouldExit = true;
                sGLThreadManager.notifyAll();
                while (!mExited) {
                    try {
                        sGLThreadManager.wait();
                    } catch (InterruptedException ex) {
                        Thread.currentThread().interrupt();
                    }
                }
            }
        }

    }

    private static class GLThreadManager {
        private static String TAG = "GLThreadManager";

        public synchronized void threadExiting(GLThread thread) {

            Log.i("GLThread", "exiting tid=" + thread.getId());

            thread.mExited = true;
            notifyAll();
        }

        /*
         * Releases the EGL context. Requires that we are already in the
         * sGLThreadManager monitor when this is called.
         */
        public void releaseEglContextLocked(GLThread thread) {
            notifyAll();
        }
    }

    private static final GLThreadManager sGLThreadManager = new GLThreadManager();
}
