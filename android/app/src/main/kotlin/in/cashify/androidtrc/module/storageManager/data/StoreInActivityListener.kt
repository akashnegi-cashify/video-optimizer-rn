package `in`.cashify.androidtrc.module.storageManager.data


import android.content.DialogInterface

interface StoreInActivityListener {

    fun showBarcode()
    fun reLaunchActivity()
    fun popOutFragments()
    fun hideButtonLayout(b: Boolean)
}