package `in`.cashify.androidtrc.util

import android.content.Context
import android.text.TextUtils
import android.util.DisplayMetrics
import android.util.Log


object ImageUrlMaker {

    private val DRAWABLE_MDPI = "mdpi"
    private val DRAWABLE_HDPI = "hdpi"
    private val DRAWABLE_XHDPI = "xhdpi"
    private val DRAWABLE_XXHDPI = "xxhdpi"
    private val DRAWABLE_XXXHDPI = "xxxhdpi"


    fun getDensitySpecificUrl(
        context: Context?,
        baseUrl: String?,
        uri: String?,
        imageName: String,
        imageFolder: String
    ): String {
        if (context == null) {
            throw NullPointerException("Context must not be null")
        }

        if (baseUrl == null || baseUrl.isEmpty()) {
            Log.d("tag", "Base url may not be null or empty")
        }

        if (uri == null || uri.isEmpty()) {
            Log.d("tag", "Uri may not be null or empty")
        }

        val densityDrawable = getDensityDrawable(context)
        return "$baseUrl$uri$imageFolder/$densityDrawable/$imageName"
    }

    fun getDensitySpecificUrl(context: Context?, baseUrl: String?, imageName: String, imageFolder: String): String {
        if (context == null) {
            throw NullPointerException("Context must not be null")
        }

        if (baseUrl == null || baseUrl.isEmpty()) {
            Log.d("tag", "Base url may not be null or empty")
        }

        val densityDrawable = getDensityDrawable(context)
        return "$baseUrl/$imageFolder/$densityDrawable/$imageName"
    }

    fun getImageUrl(context: Context?, baseUrl: String?, uri: String?, imageName: String): String {
        if (context == null) {
            throw NullPointerException("Context must not be null")
        }
        if (baseUrl == null || baseUrl.isEmpty()) {
            Log.d("tag", "Base url may not be null or empty")
        }
        if (uri == null || uri.isEmpty()) {
            Log.d("tag", "Uri may not be null or empty")
        }
        return "$baseUrl$uri/$imageName"
    }

    private fun getDensityDrawable(context: Context): String {

        val densityDpi = context.resources.displayMetrics.densityDpi

        when (densityDpi) {
            DisplayMetrics.DENSITY_LOW, DisplayMetrics.DENSITY_MEDIUM -> return DRAWABLE_MDPI

            DisplayMetrics.DENSITY_TV, DisplayMetrics.DENSITY_HIGH -> return DRAWABLE_HDPI

            DisplayMetrics.DENSITY_XHIGH, DisplayMetrics.DENSITY_280 -> return DRAWABLE_XHDPI

            DisplayMetrics.DENSITY_XXHIGH, DisplayMetrics.DENSITY_360, DisplayMetrics.DENSITY_400, DisplayMetrics.DENSITY_420, DisplayMetrics.DENSITY_XXXHIGH, DisplayMetrics.DENSITY_560 -> return DRAWABLE_XXHDPI
        }
        return DRAWABLE_XHDPI
    }

    fun isUrlPartsValid(imageBaseUrl: String, imageName: String): Boolean {
        return !TextUtils.isEmpty(imageBaseUrl) && !TextUtils.isEmpty(imageName)
    }

    fun isUrlPartsValid(imageBaseUrl: String, imageUri: String, imageName: String): Boolean {
        return !TextUtils.isEmpty(imageBaseUrl) && !TextUtils.isEmpty(imageUri) && !TextUtils.isEmpty(imageName)
    }
}
