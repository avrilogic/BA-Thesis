package th.thesis.opengles_flutter;


import android.graphics.SurfaceTexture;
import android.opengl.EGL14;
import android.opengl.GLUtils;
import android.util.Log;

import javax.microedition.khronos.egl.EGL10;
import javax.microedition.khronos.egl.EGL11;
import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.egl.EGLContext;
import javax.microedition.khronos.egl.EGLDisplay;
import javax.microedition.khronos.egl.EGLSurface;
import javax.microedition.khronos.opengles.GL;
import javax.microedition.khronos.opengles.GL10;

public class OpenGLRenderer implements Runnable {
    private static final String LOG_TAG = "OpenGL.Worker";
    protected final SurfaceTexture texture;
    private final Object mutex = new Object();
    private EGL10 egl;
    private EGLDisplay eglDisplay;
    private EGLContext eglContext;
    private EGLSurface eglSurface;
    private EGLConfig eglConfig;
    private boolean running;
    private Worker worker;
    private int width;
    private int height;
    private volatile boolean sizeChanged = true;
    private FPSCounter fpsCounter = new FPSCounter();
    private int fpsLimit = 500;

    public OpenGLRenderer(SurfaceTexture texture, Worker worker, int width, int height) {
        this.texture = texture;
        this.running = true;
        this.worker = worker;
        this.width = width;
        this.height = height;
        Thread thread = new Thread(this);
        thread.start();
    }

    @Override
    public void run() {
        initGL();
        worker.onCreate();
        Log.d(LOG_TAG, "OpenGL init OK.");

        while (true) {
            long loopStart = System.currentTimeMillis();
            synchronized (mutex) {
                if (!running) {
                    worker.onDispose();
                    deinitGL();
                    return;
                }
                checkCurrent();
                if (sizeChanged) {
                    createSurface();
                    worker.onDimensionChanged(width, height);
                    sizeChanged = false;
                }
                if (worker.onDraw()) {
                    if (!egl.eglSwapBuffers(eglDisplay, eglSurface)) {
                        Log.d(LOG_TAG, "Unable to swap buffers: " + getEglErrorString());
                    }
                }
                fpsCounter.logFrame();
            }

            // fps limit
            long wait = 1000 / fpsLimit;
            long waitDelta = wait - (System.currentTimeMillis() - loopStart);
            if (waitDelta > 0) {
                try {
                    Thread.sleep(waitDelta);
                } catch (InterruptedException e) {
                    Log.d(LOG_TAG, "Error during sleep");
                }
            }
        }
    }

    public void onDimensionsChanged(int w, int h) {
        synchronized (mutex) {
            // locked resources till set
            width = w;
            height = h;
            sizeChanged = true;
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
            eglSurface = egl.eglCreateWindowSurface(eglDisplay, eglConfig, texture, null);
        } catch (IllegalArgumentException e) {
            // This exception indicates that the surface flinger surface
            // is not valid. This can happen if the surface flinger surface has
            // been torn down, but the application has not yet been
            // notified via SurfaceHolder.Callback.surfaceDestroyed.
            // In theory the application should be notified first,
            // but in practice sometimes it is not. See b/4588890
            Log.e(LOG_TAG, "eglCreateWindowSurface", e);
            return false;
        }

        // make the GL context current
        if (!egl.eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
            Log.e(LOG_TAG, "Wasn't able to make eglContext current: " + getEglErrorString());
            return false;
        }
        Log.i(LOG_TAG, "Surface created");
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

    private void initGL() {
        egl = (EGL10) EGLContext.getEGL();
        eglDisplay = egl.eglGetDisplay(EGL10.EGL_DEFAULT_DISPLAY);
        if (eglDisplay == EGL10.EGL_NO_DISPLAY) {
            throw new RuntimeException("Was not able to retrieve egl display from eglGetDisplay");
        }

        // initialize, set major, minor version
        int[] version = new int[2];
        if (!egl.eglInitialize(eglDisplay, version)) {
            throw new RuntimeException("eglInitialize failed");
        }

        // get configs
        eglConfig = chooseEglConfig();
        eglContext = createContext(egl, eglDisplay, eglConfig);

        eglSurface = egl.eglCreateWindowSurface(eglDisplay, eglConfig, texture, null);

        if (eglSurface == null || eglSurface == EGL10.EGL_NO_SURFACE) {
            throw new RuntimeException("GL Error: " + getEglErrorString());
        }

        if (!egl.eglMakeCurrent(eglDisplay, eglSurface, eglSurface, eglContext)) {
            throw new RuntimeException("GL make current error: " + getEglErrorString());
        }
    }


    private void deinitGL() {
        egl.eglMakeCurrent(eglDisplay, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_SURFACE, EGL10.EGL_NO_CONTEXT);
        egl.eglDestroySurface(eglDisplay, eglSurface);
        egl.eglDestroyContext(eglDisplay, eglContext);
        egl.eglTerminate(eglDisplay);
        texture.release();
        Log.d(LOG_TAG, "OpenGL deinit OK.");
    }

    private EGLContext createContext(EGL10 egl, EGLDisplay eglDisplay, EGLConfig eglConfig) {
        int EGL_CONTEXT_CLIENT_VERSION = 0x3098;
        int[] attribList = {EGL_CONTEXT_CLIENT_VERSION, 2, EGL10.EGL_NONE};
        return egl.eglCreateContext(eglDisplay, eglConfig, EGL10.EGL_NO_CONTEXT, attribList);
    }

    private EGLConfig chooseEglConfig() {
        int[] amount = new int[1];
        EGLConfig[] configs = new EGLConfig[1];
        int[] configSpec = getConfigSpec();
        if (!egl.eglChooseConfig(eglDisplay, configSpec, configs, 1, amount)) {
            throw new RuntimeException("Unable to find best config parameters: " + getEglErrorString());
        } else if (amount[0] > 0) {
            return configs[0];
        }
        return null;
    }


    private static int[] getConfigSpec() {
        return new int[]{EGL10.EGL_RED_SIZE, 8, EGL10.EGL_GREEN_SIZE, 8, EGL10.EGL_BLUE_SIZE, 8, EGL10.EGL_ALPHA_SIZE, 8, EGL10.EGL_DEPTH_SIZE, 0, EGL10.EGL_STENCIL_SIZE, 0, EGL10.EGL_RENDERABLE_TYPE, EGL14.EGL_OPENGL_ES2_BIT, EGL10.EGL_NONE};
    }

    private void checkEglError() {
        final int error = egl.eglGetError();
        if (error != EGL10.EGL_SUCCESS) {
            Log.e(LOG_TAG, "eglError detected: " + GLUtils.getEGLErrorString(error));
        }
    }

    private String getEglErrorString() {
        return GLUtils.getEGLErrorString(egl.eglGetError());
    }

    @Override
    protected void finalize() throws Throwable {
        running = false;
    }

    public void onDispose() {
        running = false;
    }

    public int getFps(){
        return fpsCounter.getFps();
    }
    public interface Worker {
        void onCreate();

        boolean onDraw();

        void onDispose();

        void onDimensionChanged(int width, int height);
    }
}
