package th.thesis.method_channel_jni_test_plugin;

import android.util.Log;

public class NativeToJni {
  static final String TAG = "Cpptestlib";
  private int answer = 0;
  
  public native String reverse(String input);
  public native void provideAnser();
  public native String getHelloWorld();
  

  public int getAnswer() {
      return answer;
  }

  static {
    try {
      System.loadLibrary("nativecpptest");
    } catch (UnsatisfiedLinkError e) {
      Log.e(TAG, "Native code library failed to load.\n", e);
    }
  }
}
