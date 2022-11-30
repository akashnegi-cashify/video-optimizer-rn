package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.util.ActivityHelper
import `in`.cashify.androidtrc.util.PreferenceUtils
import `in`.cashify.androidtrc.util.ResourceProvider
import android.content.Context
import android.os.Bundle
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.LayoutRes
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelProviders
import dagger.android.support.DaggerFragment
import javax.inject.Inject

abstract class BaseDialogFragment<B : ViewDataBinding> : DaggerFragment() {

    @Inject
    lateinit var mActivityHelper: ActivityHelper

    @Inject
    lateinit var mResourceProvider: ResourceProvider

    @Inject
    lateinit var mPreferenceUtils: PreferenceUtils

    @Inject
    lateinit var factory: ViewModelProvider.Factory;

    protected var activityListener: ActivityListener? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val binding: B = DataBindingUtil.inflate(inflater, getLayoutResId(), container, false)
        onCreateView(savedInstanceState, binding)

        if (activity != null) {
            if (activity is AppCompatActivity) {
                if ((activity as AppCompatActivity).supportActionBar != null && !TextUtils.isEmpty(getTitle())) {
                    (activity as AppCompatActivity).supportActionBar?.title = getTitle()
                }
            }
        }

        return binding.root
    }

    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
    }

    open fun getTitle(): CharSequence? {
        return null
    }

    protected abstract fun onCreateView(instance: Bundle?, binding: B)

    @LayoutRes
    protected abstract fun getLayoutResId(): Int

    protected fun <T : ViewModel> getActivityViewModel(vClass: Class<T>): T? {
        if (activity == null) {
            return null
        }
        return ViewModelProviders.of(activity!!, factory).get(vClass)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is ActivityListener) {
            activityListener = context
        }
    }
}
