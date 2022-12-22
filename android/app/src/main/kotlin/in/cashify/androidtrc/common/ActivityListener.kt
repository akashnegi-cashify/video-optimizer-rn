package `in`.cashify.androidtrc.common

import android.content.DialogInterface

interface ActivityListener {
    fun showLoading(isShow: Boolean)
    fun showError(msg: String?)
    fun showDialog(
        title: String?,
        msg: String?,
        positiveButtonText: String?,
        onPositiveClick: DialogInterface.OnClickListener?
        , negButtonText: String?,
        onNegativeClick: DialogInterface.OnClickListener?
    )

    fun sessionExpire()
    fun setTitle(title: String?)
}