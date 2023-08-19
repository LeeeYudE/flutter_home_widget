package com.flutter.home.widget.flutter_home_widget

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.os.Build
import android.os.SystemClock
import android.util.Log
import android.view.View
import android.widget.RemoteViews
import androidx.core.content.FileProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider
import java.io.File
import java.lang.System.currentTimeMillis

class HomeScreenWidgetProvider : HomeWidgetProvider() {

    ///时间间隔常量
    private val INTERVAL = 1 * 60 * 1000L

    ///收到更新UI的广播
    override fun onReceive(context: Context?, intent: Intent?) {
        super.onReceive(context, intent)
        //获取桌面控件的视图
        Log.d("charco", "HomeScreenWidgetProvider.onReceive $intent")
        if(AppWidgetManager.ACTION_APPWIDGET_UPDATE == intent?.action){
            if(intent.getBooleanExtra("ALARM_UPDATE",false)){
                context?.let {
                    val ids = AppWidgetManager.getInstance(context).getAppWidgetIds(
                        ComponentName(
                            context,
                            HomeScreenWidgetProvider::class.java
                        )
                    )
                    ///手动点击的刷新，重新设置index
                    if(intent.getBooleanExtra("CLICK_REFRESH",false)){
                        HomeWidgetPlugin.getData(context).let { widgetData ->
                            val _index = widgetData.getInt("path_index", 0)
                            widgetData.edit().putInt("path_index", _index + 1).apply()
                            widgetData.edit().putLong("last_show_time", currentTimeMillis()).apply()
                        }
                    }
                    onUpdate(context, AppWidgetManager.getInstance(context),ids)
                }
            }

        }
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        Log.d("HomeWidgetProvider", "HomeScreenWidgetProvider.onUpdate ${appWidgetIds.size}}")


        ///每分钟发送一次定时发送刷新广播
        val alarm = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val intent = Intent(AppWidgetManager.ACTION_APPWIDGET_UPDATE)
        intent.putExtra("ALARM_UPDATE",true)
        var flags = PendingIntent.FLAG_UPDATE_CURRENT
        if (Build.VERSION.SDK_INT >= 23) {
            flags = flags or PendingIntent.FLAG_IMMUTABLE
        }
        val pendingIntentTwo = PendingIntent.getBroadcast(context, 0, intent, flags)
        alarm.cancel(pendingIntentTwo)
        val triggerAtTime = SystemClock.elapsedRealtime() + (10 * 1000)
        ///1分钟更新一次
        val interval = INTERVAL
        alarm.setRepeating(AlarmManager.RTC, triggerAtTime, interval, pendingIntentTwo)

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent =
                    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                val paths = widgetData.getString("paths", "")
                setViewVisibility(R.id.iv_refresh, if (paths.isNullOrEmpty()) View.GONE else View.VISIBLE)
                intent.putExtra("CLICK_REFRESH",true)
                setOnClickPendingIntent(R.id.iv_refresh, PendingIntent.getBroadcast(context, 0, intent, flags))
                // Pending intent to update counter on button click
                if (!paths.isNullOrEmpty()) {
                    val _pathList = paths.split(",")
                    val currentTimeMillis = currentTimeMillis()
                    var _index = widgetData.getInt("path_index", 0)
                    if(_index > _pathList.size - 1){
                        _index = 0
                        widgetData.edit().putInt("path_index", _index).apply()
                    }
                    val _lastShowTime = widgetData.getLong("last_show_time", 0)
                    if(_lastShowTime != 0L){
                        if(currentTimeMillis - _lastShowTime > (INTERVAL/2)){
                            _index++
                            if (_index > _pathList.size - 1) {
                                _index = 0
                            }
                            widgetData.edit().putInt("path_index", _index).apply()
                            widgetData.edit().putLong("last_show_time", currentTimeMillis).apply()
                        }
                    }else{
                        widgetData.edit().putLong("last_show_time", currentTimeMillis).apply()
                    }
                    val path = _pathList.elementAt(_index)
                    val file = File(path)
                    // 判断是否是AndroidN以及更高的版本
                    val uriForFile: Uri = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                        FileProvider.getUriForFile(
                            context,
                            context.packageName + ".fileProvider",
                            file
                        )
                    } else {
                        Uri.fromFile(file);
                    }
                    setImageViewBitmap(
                        R.id.image_view,
                        Utils.ImageSizeCompress(uriForFile, context)
                    )
                } else {
                    setImageViewResource(R.id.image_view, R.drawable.ic_wallpaper)
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }



    }
}