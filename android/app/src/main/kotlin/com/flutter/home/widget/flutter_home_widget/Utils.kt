package com.flutter.home.widget.flutter_home_widget

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import android.os.Build
import android.util.DisplayMetrics
import java.io.File
import java.io.FileInputStream
import java.io.IOException
import java.io.InputStream


object Utils {

    fun ImageSizeCompress(uri: Uri,context: Context): Bitmap? {
        var Stream: InputStream? = null
        var inputStream: InputStream? = null
        try {
            // 根据uri获取图片的流
            inputStream = context.contentResolver.openInputStream(uri)
            val options =
                BitmapFactory.Options()
            // options的in系列的设置了，injustdecodebouond只解析图片的大小，而不加载到内存中去
            options.inJustDecodeBounds = true
            // 1.如果通过options.outHeight获取图片的宽高，就必须通过decodestream解析同options赋值
            // 否则options.outheight获取不到宽高
            BitmapFactory.decodeStream(inputStream, null, options)
            // 2.通过 btm.getHeight()获取图片的宽高就不需要1的解析，我这里采取第一张方式
//            Bitmap btm = BitmapFactory.decodeStream(inputStream);
            // 以屏幕的宽高进行压缩
            val displayMetrics: DisplayMetrics = context.getResources().getDisplayMetrics()
            val heightPixels = displayMetrics.heightPixels
            val widthPixels = displayMetrics.widthPixels
            // 获取图片的宽高
            val outHeight = options.outHeight
            val outWidth = options.outWidth
            // heightPixels就是要压缩后的图片高度，宽度也一样
            val a =
                Math.ceil((outHeight / heightPixels.toFloat()).toDouble()).toInt()
            val b = Math.ceil((outWidth / widthPixels.toFloat()).toDouble()).toInt()
            // 比例计算,一般是图片比较大的情况下进行压缩
            val max = Math.max(a, b)
            if (max > 1) {
                options.inSampleSize = max
            }
            // 解析到内存中去
            options.inJustDecodeBounds = false
            //            根据uri重新获取流，inputstream在解析中发生改变了
            Stream = context.contentResolver.openInputStream(uri)
            return BitmapFactory.decodeStream(Stream, null, options)
        } catch (e: java.lang.Exception) {
            e.printStackTrace()
        } finally {
            try {
                inputStream?.close()
                Stream?.close()
            } catch (e: IOException) {
                e.printStackTrace()
            }
        }
        return null
    }


}