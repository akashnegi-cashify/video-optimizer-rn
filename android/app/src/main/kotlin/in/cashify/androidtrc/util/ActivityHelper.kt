package `in`.cashify.androidtrc.util

import android.text.TextUtils
import android.util.Log
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style
import javax.inject.Inject

open class ActivityHelper @Inject constructor() {

    fun showSnackBar(activity: FragmentActivity?, message: String?, style: Style?, view: ViewGroup?) {
        if (activity == null || message == null || message.isEmpty() || style == null) {
            return
        }
        if (crouton != null) {
            crouton?.cancel()
            crouton = null
        }
        if (view == null) {
            crouton = Crouton.makeText(activity, message, style)
        } else {
            crouton = Crouton.makeText(activity, message, style, view)
        }
        activity.runOnUiThread(Runnable { crouton?.show() })
    }

    fun log(message: String) {
        if (!TextUtils.isEmpty(message)) {
            Log.v(TAG, message)
        }
    }

    fun refreshFragment(fragment: Fragment) {
        val activity = fragment.getActivity()
        if (activity != null) {
            val ft = activity.supportFragmentManager.beginTransaction()
            ft.detach(fragment)
            ft.attach(fragment)
            ft.commitAllowingStateLoss()
        }
    }

    fun getTopFragment(activity: FragmentActivity, containerId: Int): Fragment? {
        val manager = activity.getSupportFragmentManager() ?: return null
        return manager.findFragmentById(containerId)
    }

    @JvmOverloads
    fun addFragment(
        activity: FragmentActivity,
        fragment: Fragment,
        containerId: Int,
        addToBackStack: Boolean = false,
        tag: String
    ) {
        val manager = activity.supportFragmentManager
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.add(containerId, fragment, tag)
        if (addToBackStack) {
            fragmentTransaction.addToBackStack(fragment.javaClass.simpleName)
        }
        fragmentTransaction.commit()
    }


    @JvmOverloads
    fun addFragment(activity: FragmentActivity, fragment: Fragment, containerId: Int, addToBackStack: Boolean = false) {
        addFragment(activity, fragment, containerId, addToBackStack, fragment.javaClass.simpleName)
    }

    @JvmOverloads
    fun addFragmentWithAnimation(activity: FragmentActivity, fragment: Fragment, containerId: Int, addToBackStack: Boolean = false, enterAnim : Int, exitAnim : Int ) {
        val manager = activity.supportFragmentManager
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.setCustomAnimations(enterAnim, exitAnim)
        fragmentTransaction.add(containerId, fragment, fragment.javaClass.simpleName)
        if (addToBackStack) {
            fragmentTransaction.addToBackStack(fragment.javaClass.simpleName)
        }
        fragmentTransaction.commit()

    }


    @JvmOverloads
    fun replaceFragment(
        activity: FragmentActivity,
        fragment: Fragment?,
        containerId: Int,
        addToBackStack: Boolean = false
    ) {
        val manager = activity.supportFragmentManager
        if (fragment == null) {
            return
        }
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.replace(containerId, fragment, fragment.javaClass.simpleName)
        if (addToBackStack) {
            fragmentTransaction.addToBackStack(fragment.javaClass.simpleName)
        }
        fragmentTransaction.commitAllowingStateLoss()
    }


    @JvmOverloads
    fun replaceFragmentWithTag(
        activity: FragmentActivity,
        fragment: Fragment?,
        containerId: Int,
        addToBackStack: Boolean = false,
        tagName: String
    ) {
        val manager = activity.supportFragmentManager
        if (fragment == null) {
            return
        }
        val fragmentTransaction = manager.beginTransaction()
        fragmentTransaction.replace(containerId, fragment, tagName)
        if (addToBackStack) {
            fragmentTransaction.addToBackStack(tagName)
        }
        fragmentTransaction.commitAllowingStateLoss()
    }

    fun showAlertDialog(activity: FragmentActivity, alertDialogFragment: DialogFragment?, tagName: String) {
        val manager = activity.supportFragmentManager
        if (alertDialogFragment == null) {
            return
        }
        val fragmentByTag = manager.findFragmentByTag(tagName)
        if (fragmentByTag != null) {
            return
        }
        val transaction = manager.beginTransaction()
        transaction.add(alertDialogFragment, tagName)
        transaction.commitAllowingStateLoss()
    }


    companion object {

        private val TAG = "Cashify"
    }

    private var crouton: Crouton? = null
}
