package com.roshancodespace.shonenx

import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {
    override fun onDestroy() {
        if (!isChangingConfigurations) stopService(Intent(this, DownloadService::class.java))
        super.onDestroy()
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "shonenz/downloads").setMethodCallHandler { call, result ->
            try {
                val intent = Intent(this, DownloadService::class.java)
                when (call.method) {
                    "start" -> { if (Build.VERSION.SDK_INT >= 26) startForegroundService(intent) else startService(intent); result.success(null) }
                    "stop" -> { stopService(intent); result.success(null) }
                    else -> result.notImplemented()
                }
            } catch (error: Exception) { result.error("download_service", error.message, null) }
        }
    }
}
