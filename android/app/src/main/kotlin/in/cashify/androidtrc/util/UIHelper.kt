package `in`.cashify.androidtrc.util

import android.app.Activity
import android.content.Context
import android.graphics.drawable.Drawable
import android.os.Build
import android.text.TextUtils
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style

/**
 * Created by gup on 25/08/2015.
 * UIHelper
 */
object UIHelper {

    private val TAG = "Cashify"
    lateinit var crouton: Crouton

    fun getTopFragment(manager: FragmentManager?, containerId: Int): Fragment? {
        return manager?.findFragmentById(containerId)
    }

    fun addFragment(manager: FragmentManager?, fragment: Fragment?, containerId: Int) {
        if (manager == null || fragment == null) {
            return
        }
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.add(containerId, fragment, fragment.javaClass.simpleName)
        fragmentTransaction.addToBackStack(fragment.javaClass.simpleName)
        fragmentTransaction.commit()
    }

    fun replaceFragment(manager: FragmentManager?, fragment: Fragment?, containerId: Int) {
        if (manager == null || fragment == null) {
            return
        }
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.replace(containerId, fragment, fragment.javaClass.simpleName)
        fragmentTransaction.commitAllowingStateLoss()
    }

    fun showSnackBar(activity: Activity?, message: String, style: Style, view: ViewGroup?) {
        if (activity == null || message.isEmpty()) {
            return;
        }
        if (view == null) {
            crouton = Crouton.makeText(activity, message, style);
        } else {
            crouton = Crouton.makeText(activity, message, style, view);
        }
        activity.runOnUiThread() {
            Crouton.cancelAllCroutons()
            crouton.show()
        }
    }

    fun log(message: String) {
        if (!TextUtils.isEmpty(message)) {
            Log.v(TAG, message)
        }
    }

    fun convertDpToPixel(dp: Float, context: Context): Int {
        val resources = context.resources
        val metrics = resources.displayMetrics
        return (dp * (metrics.densityDpi / 160f)).toInt()
    }

    fun getSizeFromResourcesId(resourceId: Int, context: Context): Float {
        return context.resources.getDimension(resourceId)
    }

    fun setUpforKeyboard(p_view: View?, activity: Activity?) {
        if (p_view == null || activity == null) {
            return
        }
        if (p_view !is EditText) {
            p_view.setOnTouchListener { _, _ ->
                hideSoftKeyboard(activity)
                false
            }
        }
        if (p_view is ViewGroup) {
            for (i in 0 until p_view.childCount) {
                val innerView = p_view.getChildAt(i)
                setUpforKeyboard(innerView, activity)
            }
        }
    }

    fun hideSoftKeyboard(activity: Activity?) {
        if (activity == null) return
        if (activity.currentFocus != null) {
            val inputMethodManager =
                activity.applicationContext.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            inputMethodManager.hideSoftInputFromWindow(activity.currentFocus!!.windowToken, 0)
        }
    }

    fun hideSoftKeyboard(activity: Activity?, viewFocus: View?) {
        if (activity == null) return
        if (viewFocus != null) {
            val inputMethodManager =
                activity.applicationContext.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            inputMethodManager.hideSoftInputFromWindow(viewFocus.windowToken, 0)
        }
    }

    fun getColor(context: Context, resourceId: Int): Int {
        //        if (context == null) {
        //            return CommonConstant.EMPTY;
        //        }
        return ContextCompat.getColor(context, resourceId)
    }

    fun openKeyBoard(context: Context, view: View?) {
        val inputManager =
            context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        if (view != null) {
            inputManager.toggleSoftInputFromWindow(
                view.applicationWindowToken,
                InputMethodManager.SHOW_FORCED,
                0
            )
        }
    }

    fun refreshFragment(fragment: Fragment) {
        val activity = fragment.activity
        if (activity != null) {
            val ft = activity.supportFragmentManager.beginTransaction()
            ft.detach(fragment)
            ft.attach(fragment)
            ft.commit()
        }
    }

}
