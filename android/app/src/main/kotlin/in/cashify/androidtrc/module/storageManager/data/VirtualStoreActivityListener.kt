package `in`.cashify.androidtrc.module.storageManager.data


import android.content.DialogInterface

interface StorageOutActivityListener {

    fun showStoreOutFragment()
     fun reLaunchActivity()
    fun hideButtonLayout(b: Boolean)

}