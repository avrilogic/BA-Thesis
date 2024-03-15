package com.example.method_channel

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.PigeonImpl

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MyMethodChannels(flutterEngine.dartExecutor.binaryMessenger, applicationContext)
        flutterEngine.plugins.add(PigeonImpl())
    }



}
