package io.flutter.plugins;

import static java.util.stream.Collectors.toList;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

public class PigeonImpl implements FlutterPlugin, Messages.MethodChannelPigeon {
    private Context context;

    private void setup(BinaryMessenger messenger, Context context) {
        try {
            Messages.MethodChannelPigeon.setUp(messenger, this);
        } catch (Exception e) {
            Log.e("PigeonImpl", "Failed during Setup", e);
        }
        this.context = context;
    }

    @NonNull
    @Override
    public String reverse(@NonNull String input) {
        int length = input.length();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            sb.append(input.charAt(length - 1 - i));
        }
        return sb.toString();
    }

    @NonNull
    @Override
    public Long add(@NonNull Long a, @NonNull Long b) {
        long result = a + b;
        return result;
    }

    @NonNull
    @Override
    public Long subtract(@NonNull Long a, @NonNull Long b) {
        long result = a - b;
        return result;
    }

    @NonNull
    @Override
    public Long multiply(@NonNull Long a, @NonNull Long b) {
        long result = a * b;
        return result;
    }

    @NonNull
    @Override
    public Long divide(@NonNull Long a, @NonNull Long b) {
        long result = a / b;
        return result;
    }

    @NonNull
    @Override
    public Messages.ComplexStructure getComplexStructure() {
        Messages.ComplexStructure.Builder builder = new Messages.ComplexStructure.Builder();
        builder.setA(10L);
        builder.setB(20L);
        builder.setC("String");
        builder.setMyList( Arrays.asList(10L,20L,30L));
        Map<String, String> map = new HashMap();
        map.put("name", "jean");
        map.put("lastname", "avril");
        builder.setMyKvMap(map);
        return builder.build();
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        setup(binding.getBinaryMessenger(), binding.getApplicationContext());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Messages.MethodChannelPigeon.setUp(binding.getBinaryMessenger(), null);
    }
}
