package th.thesis.opengles_android;
import android.graphics.Color;

public class ColorPalette {


    static float[] violet() {
        return new float[]{
                Color.red(Color.parseColor("#8A2BE2")) / 255f,
                Color.green(Color.parseColor("#8A2BE2")) / 255f,
                Color.blue(Color.parseColor("#8A2BE2")) / 255f,
                1.0f
        };
    }

    static float[] white() {
        return new float[]{
                Color.red(Color.WHITE) / 255f,
                Color.green(Color.WHITE) / 255f,
                Color.blue(Color.WHITE) / 255f,
                1.0f
        };
    }
    static float[] blue() {
        return new float[]{
                Color.red(Color.BLUE) / 255f,
                Color.green(Color.BLUE) / 255f,
                Color.blue(Color.BLUE) / 255f,
                1.0f
        };
    }
}