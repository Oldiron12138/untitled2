package com.example.untitled2

import android.annotation.SuppressLint
import android.content.Context
import android.view.View

import android.view.WindowManager

import android.os.Build
import android.app.Activity
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
import android.view.ViewGroup
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

//import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.view.FlutterMain


import java.io.File
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.untitled2/battery_power"

    override fun onCreate(savedInstanceState: Bundle?) {
        FlutterMain.startInitialization(this);
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))


        MethodChannel(flutterEngine?.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
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

    @SuppressLint("ServiceCast")
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(
                Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }


    override fun onResume() {
        //setRootViewFitsSystemWindows(this, true)
        super.onResume()

        // Add the FLAG_KEEP_SCREEN_ON flag for keeping on screen.
        window.clearFlags(WindowManager.LayoutParams.FLAG_FORCE_NOT_FULLSCREEN)
//        window.addFlags(
//            WindowManager.LayoutParams.FLAG_FULLSCREEN or
//                    WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
//                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS or
//                    WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
//        )
        hideNavigationBar()
    }

    private fun hideNavigationBar() {
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY or
                View.SYSTEM_UI_FLAG_HIDE_NAVIGATION or
                View.SYSTEM_UI_FLAG_FULLSCREEN
    }

    fun setRootViewFitsSystemWindows(activity: Activity, fitSystemWindows: Boolean) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            val winContent = activity.findViewById<View>(android.R.id.content) as ViewGroup
            if (winContent.childCount > 0) {
                val rootView = winContent.getChildAt(0) as ViewGroup
                if (rootView != null) {
                    rootView.fitsSystemWindows = fitSystemWindows
                }
            }
        }
    }
}
