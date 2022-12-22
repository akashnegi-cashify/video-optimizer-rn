package `in`.reglobe.cashify.util.cache


import android.app.ActivityManager
import android.content.Context
import android.util.Log

import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

/**
 * Created by raghav on 28/01/16.
 * MemoryUtils
 */
object MemoryUtils {

    //memory info
    val totalMemory: Long
        get() {
            var localBufferedReader: BufferedReader? = null
            try {
                val localFileReader = FileReader("/proc/meminfo")
                localBufferedReader = BufferedReader(localFileReader)
                val memInfo = localBufferedReader.readLine()
                val arrayOfString = memInfo.split("\\s+".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
                for (num in arrayOfString) {
                    Log.i(memInfo, num + "\t")
                }
                return (Integer.valueOf(arrayOfString[1]) * 1024).toLong()
            } catch (e: IOException) {
                return -1
            } finally {
                try {
                    localBufferedReader?.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }

            }
        }

    fun getUsedMemoryPercent(context: Context): Int {
        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        activityManager.getMemoryInfo(memoryInfo)

        val availMem = memoryInfo.availMem
        val totalMem: Long
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN) {
            totalMem = memoryInfo.totalMem
        } else {
            totalMem = MemoryUtils.totalMemory
        }
        val usedMemory = totalMem - availMem
        return if (totalMem > 0) {
            (usedMemory / totalMem.toDouble() * 100).toInt()
        } else 0
    }
}//stop being instantiated
