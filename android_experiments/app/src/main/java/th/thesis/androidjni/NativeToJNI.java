package th.thesis.androidjni;

public class NativeToJNI {

    public native void myJniCall();

    // native stuff
    public native String reverse(String input);
    public native void provideAnser();

    // fields
    private int answer = 0;

    public int getAnswer() {
        return answer;
    }

    static {
        System.loadLibrary("androidjni");
    }
}
