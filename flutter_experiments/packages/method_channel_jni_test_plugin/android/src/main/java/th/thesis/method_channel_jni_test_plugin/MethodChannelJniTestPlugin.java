package th.thesis.method_channel_jni_test_plugin;

import android.content.Context;
import android.util.Log;

import th.thesis.method_channel_jni_test_plugin.Messages.CppExperimentPigeon;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;

/**
 * CpptestlibPlugin
 */
public class MethodChannelJniTestPlugin implements FlutterPlugin, CppExperimentPigeon {

  static final String TAG = "MethodChannelJniTestPlugin";
  private Context context;
  private NativeToJni libNative;

  private void setup(BinaryMessenger messenger, Context context) {
    try {
      CppExperimentPigeon.setUp(messenger, this);
    } catch (Exception ex) {
      Log.e(TAG, "Received exception while setting up PathProviderPlugin", ex);
    }

    this.context = context;
    libNative = new NativeToJni();
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    setup(flutterPluginBinding.getBinaryMessenger(), flutterPluginBinding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    CppExperimentPigeon.setUp(binding.getBinaryMessenger(), null);
  }

  @Override
  public String getCPPHelloWorld() {
    return libNative.getHelloWorld();

  }

  @Override
  public String getAndroidVersion() {
    return "Android version is " + android.os.Build.VERSION.RELEASE;
  }

  @Override
  public String reverse(String str) {
    return libNative.reverse(str);
  }

  @Override
  public Long getAnswer() {
    return (long) libNative.getAnswer();
  }

  @Override
  public void provideAnswer() {
    libNative.provideAnser();
  }


  @Override
  public byte[] benchmark(byte[] request) {
    return libNative.benchmark(request);
  }

}
