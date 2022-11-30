package `in`.cashify.androidtrc.util

import `in`.cashify.androidtrc.R
import android.app.AlertDialog
import android.app.Dialog
import android.os.Bundle
import android.os.CountDownTimer
import android.os.Handler
import android.view.View
import android.widget.Button
import android.widget.ProgressBar
import android.widget.TextView
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentManager
import kotlinx.android.synthetic.main.dialog_progress.*

class TrcProgressDialog : DialogFragment(), View.OnClickListener {
    override fun onClick(v: View?) {
        dismiss()
    }

    private var mBtnCancel: Button? = null
    private var mTvProgress: TextView? = null
    private var mProgressBar: ProgressBar? = null
    private var fManager: FragmentManager? = null
    private var frTag: String? = null
    private var showHandler: Handler? = null
    private var timer: CountDownTimer? = null

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val builder = AlertDialog.Builder(activity)
        val inflater = activity!!.layoutInflater
        builder.setView(inflater.inflate(R.layout.dialog_progress, null))
        return builder.create()
    }

    override fun onStart() {
        super.onStart()
        mProgressBar = dialog?.findViewById(R.id.progress_bar)
        mTvProgress = dialog?.findViewById(R.id.tv_progress_msg)
        mBtnCancel = dialog?.findViewById(R.id.btn_cancel)
        mBtnCancel?.setOnClickListener(this)
    }

    override fun show(fm: FragmentManager, tag: String?) {
        if (isAdded)
            return

        this.fManager = fm
        this.frTag = tag

        showHandler = Handler()
        showHandler!!.post {
            showDialog()
        }
    }

    private fun showDialog() {
        val dialogFragment = fManager?.findFragmentByTag(frTag) as DialogFragment?
        if (dialogFragment != null) {
            fManager?.beginTransaction()?.show(dialogFragment)?.commitAllowingStateLoss()
        } else {
            val ft = fManager!!.beginTransaction()
            ft.add(this, frTag)
            ft.commitAllowingStateLoss()
        }

        if (timer != null) {
            timer?.cancel()
            timer = null
        }
        timer = object : CountDownTimer(20 * 1000, 1 * 1000) {
            override fun onFinish() {

            }

            override fun onTick(millisUntilFinished: Long) {
                if (millisUntilFinished < 15 * 1000) {
                    mTvProgress?.text = "Taking time longer than usual."
                }
                if (millisUntilFinished < 10 * 1000) {
                    mTvProgress?.text = "It seems internet is slow."
                }
//                if (millisUntilFinished < 5 * 1000) {
//                    mBtnCancel?.visibility = View.VISIBLE
//                }
            }
        }
        timer?.start()
    }

    override fun dismiss() {
        if (timer != null) {
            timer?.cancel()
            timer = null
        }
        val ft = fManager?.beginTransaction()
        ft?.remove(this)
        ft?.commitAllowingStateLoss()
    }

    companion object {
    }
}