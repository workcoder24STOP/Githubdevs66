package com.roshancodespace.shonenx

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder

/** Keeps active in-process transfers eligible while the app is backgrounded. */
class DownloadService : Service() {
    override fun onBind(intent: Intent?): IBinder? = null
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val manager = getSystemService(NotificationManager::class.java)
        if (Build.VERSION.SDK_INT >= 26) {
            manager.createNotificationChannel(NotificationChannel("offline_transfers", "Downloads", NotificationManager.IMPORTANCE_LOW))
        }
        val open = PendingIntent.getActivity(this, 0, Intent(this, MainActivity::class.java), PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)
        val builder = if (Build.VERSION.SDK_INT >= 26) Notification.Builder(this, "offline_transfers") else Notification.Builder(this)
        startForeground(8401, builder.setContentTitle("ShonenZ+ downloads")
            .setContentText("Open the offline library to pause or manage transfers")
            .setSmallIcon(android.R.drawable.stat_sys_download).setContentIntent(open).setOngoing(true).build())
        return START_NOT_STICKY // Isar checkpoints recover tasks on the next launch.
    }
    override fun onTimeout(startId: Int, fgsType: Int) { stopSelf() }
}
