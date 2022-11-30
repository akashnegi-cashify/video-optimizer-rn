package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.util.AppUtils
import `in`.cashify.androidtrc.util.PreferenceUtils
import `in`.cashify.androidtrc.util.ResourceProvider
import `in`.cashify.androidtrc.util.cache.ImageCaching
import `in`.reglobe.api.kotlin.exception.APIException
import android.view.View
import android.widget.EditText
import android.widget.ImageView
import androidx.databinding.BindingAdapter
import androidx.lifecycle.ViewModel
import androidx.recyclerview.widget.RecyclerView
import javax.inject.Inject

open class BaseViewModel @Inject constructor() : ViewModel() {

    @Inject
    lateinit var mResourceProvider: ResourceProvider

    @Inject
    lateinit var mPreferenceUtils: PreferenceUtils

    var activityListener: ActivityListener? = null

    interface BindableAdapter<T> {
        fun setData(data: T)

    }

    companion object {
        @JvmStatic
        @BindingAdapter("error")
        fun <T> setError(editText: EditText, res: Any?) {

            if (res == null) {
                return
            }

            if (res is Int) {
                editText.error = editText.context.getString(res);
            } else {
                if (!(res as String).isBlank()) {
                    editText.error = res;
                }
            }

        }

        @JvmStatic
        @BindingAdapter("data")
        fun <T> setRecyclerViewProperties(recyclerView: RecyclerView, data: T) {
            if (recyclerView.adapter is BindableAdapter<*>) {
                (recyclerView.adapter as BindableAdapter<T>).setData(data)
            }
        }

        @JvmStatic
        @BindingAdapter("imageUrl")
        fun loadImage(view: ImageView, imageUrl: String?) {
            if (imageUrl == null) {
                return
            }
            ImageCaching(view.context)
                .load(imageUrl)
                .placeholder(R.drawable.ic_placeholder).into(view)
        }

        @JvmStatic
        @BindingAdapter("visibility")
        fun loadImage(view: View, visibility: Int?) {
            if (visibility == null) {
                return
            }
            view.visibility = visibility
        }
    }

    fun getErrorMsg(apiError: APIException?): String? {
        var errMsg: String? = "Something went wrong"
        if (apiError?.error != null) {
            errMsg = apiError.error?.message
        } else if (apiError != null) {
            errMsg = apiError.message
        }
        return errMsg ?: "Something went wrong"
    }

    @Inject
    lateinit var appUtils: AppUtils


}