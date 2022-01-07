package com.example.untitled2

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.view.View

import android.view.WindowManager

import android.os.Build
import android.app.Activity
import android.view.ViewGroup
import java.io.File
class MainActivity: FlutterActivity() {
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
