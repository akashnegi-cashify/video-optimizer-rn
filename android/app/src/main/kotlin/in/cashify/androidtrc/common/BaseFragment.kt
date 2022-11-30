package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.util.ActivityHelper
import `in`.cashify.androidtrc.util.PreferenceUtils
import `in`.cashify.androidtrc.util.ResourceProvider
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.DialogInterface
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.EditText
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import dagger.android.support.AndroidSupportInjection
import dagger.android.support.DaggerFragment
import javax.inject.Inject

abstract class BaseFragment : DaggerFragment() {

    @Inject
    lateinit var mActivityHelper: ActivityHelper

    @Inject
    lateinit var mResourceProvider: ResourceProvider

    @Inject
    lateinit var mPreferenceUtils: PreferenceUtils

    @Inject
    lateinit var factory: ViewModelProvider.Factory;

    protected var activityListener: ActivityListener? = null

    open fun getTitle(): CharSequence? {
        return null
    }

    protected fun <T : ViewModel> getActivityViewModel(vClass: Class<T>): T? {
        if (activity == null) {
            return null
        }
        return ViewModelProviders.of(activity!!, factory).get(vClass)
    }

    override fun onAttach(context: Context) {
        AndroidSupportInjection.inject(this)
        super.onAttach(context)
        if (context is ActivityListener) {
            activityListener = context
        }
    }

    protected fun showDialog(
        title: String?,
        positiveButtonText: String,
        msg: String?,
        onPositiveClick: DialogInterface.OnClickListener?
    ) {
        if (context == null) {
            return
        }
        val builder = AlertDialog.Builder(context!!)
        builder.setTitle(title)
            .setMessage(msg)
            .setPositiveButton(positiveButtonText, onPositiveClick)
            .setNegativeButton("Cancel", null)
            .setCancelable(false)
        val alertDialog = builder.create()
        alertDialog.show()
    }

    protected fun showDialogBar(
        title: String?,
        positiveButtonText: String,
        msg: String?,
        onPositiveClick: DialogInterface.OnClickListener?
    ) {
        if (context == null) {
            return
        }
        val builder = AlertDialog.Builder(context!!)
        builder.setTitle(title)
            .setMessage(msg)
            .setPositiveButton(positiveButtonText, onPositiveClick)
            .setCancelable(false)
        val alertDialog = builder.create()
        alertDialog.show()
    }

    fun showDialog(
        title: String?,
        msg: String?,
        positiveButtonText: String?,
        onPositiveClick: DialogInterface.OnClickListener?
        , negButtonText: String?,
        onNegativeClick: DialogInterface.OnClickListener?
    ) {
        val builder = AlertDialog.Builder(context!!)
        builder.setTitle(title)
            .setMessage(msg)
            .setPositiveButton(positiveButtonText, onPositiveClick)
            .setNegativeButton(negButtonText, onNegativeClick)
            .setCancelable(false)
        val alertDialog = builder.create()
        alertDialog.show()
    }

    fun showAlertDialog(
        positiveButtonText: String,
        msg: String?,
        onPositiveClick: DialogInterface.OnClickListener?,
        s: String,
        onClickListener: DialogInterface.OnClickListener
    ) {
        showDialog("Alert", positiveButtonText, msg, onPositiveClick)
    }

    fun showWarningDialog(
        positiveButtonText: String,
        msg: String?,
        onPositiveClick: DialogInterface.OnClickListener?
    ) {
        showDialog("Warning", positiveButtonText, msg, onPositiveClick)
    }



    @SuppressLint("ClickableViewAccessibility")
    fun setupUI(view: View) {
        if (view !is EditText) {
            view.setOnTouchListener { _, _ ->
                this.hideSoftKeyboard(activity)
                false
            }
        }
        if (view is ViewGroup) {
            for (i in 0 until view.childCount) {
                val innerView = view.getChildAt(i)
                setupUI(innerView)
            }
        }
    }

    private fun hideSoftKeyboard(activity: Activity?) {
        if (activity == null) {
            return
        }
        if (activity.currentFocus != null) {
            val inputMethodManager =
                context!!
                    .getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
            inputMethodManager.hideSoftInputFromWindow(
                activity.currentFocus!!.windowToken, 0
            )
        }
    }



  open  fun onBackPressed():Boolean{
        return false
    }
}
