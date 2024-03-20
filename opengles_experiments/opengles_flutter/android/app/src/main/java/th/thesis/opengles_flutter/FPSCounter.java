package th.thesis.opengles_flutter;

public class FPSCounter {
    private long lastFrameTime;
    private int frames;
    private int fps;

    public synchronized void logFrame() {
        long time = System.currentTimeMillis();
        if (lastFrameTime == 0) {
            lastFrameTime = time;
        }
        frames++;
        if (time - lastFrameTime > 1000) {
            fps = frames;
            frames = 0;
            lastFrameTime = time;
        }
    }

    public int getFps() {
        return fps;
    }
}

