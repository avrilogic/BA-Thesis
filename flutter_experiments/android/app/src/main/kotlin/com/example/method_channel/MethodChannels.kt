package com.example.method_channel

import android.content.Context
import android.os.BatteryManager
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class MyMethodChannels(messenger: BinaryMessenger, private val applicationContext: Context) {
    private val BATTERY_LEVEL_CHANNEL = "th.thesis.platform_channel/battery"

    init {
        MethodChannel(messenger , BATTERY_LEVEL_CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        val batteryManager =
                applicationContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

        return batteryLevel
    }
}
