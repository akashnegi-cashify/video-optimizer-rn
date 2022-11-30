package `in`.cashify.androidtrc.util

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment

object PermissionUtils {

    fun hasPermission(context: Context?, permission: String?): Boolean {
        return Build.VERSION.SDK_INT < Build.VERSION_CODES.M || !(context == null || permission == null || permission.trim { it <= ' ' }.isEmpty()) && ContextCompat.checkSelfPermission(
            context,
            permission
        ) == PackageManager.PERMISSION_GRANTED
    }

    fun hasPermission(context: Context): Boolean {
        val pm = context.packageManager
        val hasPerm = pm.checkPermission(
            Manifest.permission.CAMERA, context.packageName
        )

        return hasPerm == PackageManager.PERMISSION_GRANTED
    }

    fun hasPermissions(context: Context, permissions: Array<String>?): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return true
        }
        if (permissions == null || permissions.size == 0) {
            return false
        }
        for (permission in permissions) {
            if (!hasPermission(context, permission)) {
                return false
            }
        }
        return true
    }

    fun requestPermissions(activity: Activity?, permissions: Array<String>?, requestId: Int) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return
        }
        if (activity == null || permissions == null || permissions.size == 0) {
            return
        }
        activity.requestPermissions(permissions, requestId)
    }

    fun requestPermissions(fragment: Fragment?, permissions: Array<String>?, requestId: Int) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M || requestId and -0x10000 != 0) {
            return
        }
        if (fragment == null || permissions == null || permissions.size == 0) {
            return
        }
        fragment.requestPermissions(permissions, requestId)
    }
}
