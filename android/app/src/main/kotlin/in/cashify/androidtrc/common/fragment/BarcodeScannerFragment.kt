package `in`.cashify.androidtrc.common.fragment

import `in`.cashify.barcode_scanner.BarcodeReaderFragment
import android.content.Context
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import android.view.View
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style

/**
 * Created by apple on 5/31/18.
 * ${CLASS}
 */
class BarcodeScannerFragment : BarcodeReaderFragment(), BarcodeReaderFragment.RawBarcodeCaptureListener {
    private var scannerListener: BarcodeScannerListener? = null
    private var needToMatch: String? = null

    fun setBarcodeScannerListener(scannerListener: BarcodeScannerListener) {
        this.scannerListener = scannerListener
         setRawBarcodeCaptureListener(this)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val arguments = this.arguments
        if (arguments != null) {
            this.b = arguments.getBoolean(KEY_AUTO_FOCUS, false)
            this.c = arguments.getBoolean(KEY_USE_FLASH, false)
            this.needToMatch = arguments.getString(KEY_BARCODE_MATCH, "")

            Log.e("Cashify_Temp", "onCreate_BarcodeScannerFragment")

        }
    }

    override fun onRawBarcodeCaptured(barcode: String) {
        playBeep()
        val activity = activity
        if (activity == null || !isAdded) {
            return
        }
        activity.runOnUiThread {
            if (scannerListener != null) {
                if (TextUtils.isEmpty(needToMatch)) {
                    scannerListener!!.onBarcodeScanned(barcode)
                } else if (needToMatch!!.equals(barcode, ignoreCase = true)) {
                    scannerListener!!.onBarcodeScanned(barcode)
                } else {
                    try {
                        Crouton.makeText(activity, "Barcode Mismatch\nTry again!", Style.ALERT).show()
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }

                }
            }
        }


    }

    interface BarcodeScannerListener {
        fun onBarcodeScanned(barcode: String)
        fun hideLayout(show: Boolean)

    }

    fun resumeScanner()
    {
        resumeScanning()
    }

    override fun onPause()
    {
        super.onPause()
        scannerListener!!.hideLayout(true)
        Log.e("Cashify_Temp", "onPause_BarcodeScannerFragment")
    }

    override fun onResume()
    {
        super.onResume()
        scannerListener!!.hideLayout(false)
        Log.e("Cashify_Temp", "onResume_BarcodeScannerFragment")

    }

    fun pauseScanner() {
        pauseScanning()
    }

    override fun onViewCreated(p0: View, p1: Bundle?)
    {
        super.onViewCreated(p0, p1)

        Log.e("Cashify_Temp", "onViewCreated_BarcodeScannerFragment")

    }

    companion object {
        val TAG = "BarcodeScannerFragment"
        private val KEY_BARCODE_MATCH = "key_barcode_match"
        protected val KEY_AUTO_FOCUS = "key_auto_focus"
        protected val KEY_USE_FLASH = "key_use_flash"

        fun newInstance(autoFocus: Boolean, useFlash: Boolean): BarcodeScannerFragment {

            val args = Bundle()
            args.putBoolean(KEY_AUTO_FOCUS, autoFocus)
            args.putBoolean(KEY_USE_FLASH, useFlash)
            val fragment = BarcodeScannerFragment()
            fragment.arguments = args
            return fragment
        }

        fun newInstance(needToMatch: String?, autoFocus: Boolean, useFlash: Boolean): BarcodeScannerFragment {

            val args = Bundle()
            args.putString(KEY_BARCODE_MATCH, needToMatch)
            args.putBoolean(KEY_AUTO_FOCUS, autoFocus)
            args.putBoolean(KEY_USE_FLASH, useFlash)
            val fragment = BarcodeScannerFragment()
            fragment.arguments = args
            return fragment
        }
    }


    override  fun onStart()
    {
        super.onStart()

        Log.e("Cashify_Temp", "onStart_BarcodeScannerFragment")


    }


    override fun onStop()
    {
        super.onStop()

        Log.e("Cashify_Temp", "onStop_BarcodeScannerFragment")


    }

    override fun onDestroyView()
    {
        super.onDestroyView()

        Log.e("Cashify_Temp", "onDestroyView_BarcodeScannerFragment")


    }

    override fun onDestroy()
    {
        super.onDestroy()

        Log.e("Cashify_Temp", "onDestroy_BarcodeScannerFragment")


    }

    override fun onDetach()
    {
        super.onDetach()

        if(scannerListener!=null)
        scannerListener!!.hideLayout(true)

        Log.e("Cashify_Temp", "onDetach_BarcodeScannerFragment")


    }


    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.e("Cashify_Temp", "onAttach_BarcodeScannerFragment")

    }



}