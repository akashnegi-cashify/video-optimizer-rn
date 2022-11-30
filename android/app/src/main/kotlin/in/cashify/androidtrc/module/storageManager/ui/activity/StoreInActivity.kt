package `in`.cashify.androidtrc.module.storageManager.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityStoreInBinding
import `in`.cashify.androidtrc.module.engineer.api.response.FetchStorageDetailsResponse
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.module.storageManager.data.StoreInActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreInViewModel
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreInHomeFragment
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders


class StoreInActivity : BaseActivity(), View.OnClickListener,BarcodeScannerFragment.BarcodeScannerListener , StoreInActivityListener
{


    private lateinit var binding: ActivityStoreInBinding
    private lateinit var viewModel: StoreInViewModel
    private lateinit var scannerFragment: BarcodeScannerFragment


    override fun getLayoutResId(): Int
    {
        return R.layout.activity_store_in
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    )
    {
        Log.e("Cashify_Temp", "onCreate_Activity")

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_STORE_IN, null, null, true)

        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(StoreInViewModel::class.java)
        binding.lifecycleOwner = this

        viewModel.activityListener = this
        viewModel.storeInActivityListener = this
        viewModel.isDeviceBarcode = false
        viewModel.barcodeHeading = "Tray Barcode"

        binding.barcodeType.text = viewModel.barcodeHeading





        binding.btnSubmitBarcode.setOnClickListener(this)

        showBarcodeFragment("scanner_tray")

        setTitle("Device Store In")





    }

    fun showBarcodeFragment(tag : String)
    {
        resetBarcodeUI()

        createScannerBarcode(tag)
    }

    private fun createScannerBarcode(tag: String)
    {
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        mActivityHelper.addFragment(this, scannerFragment,binding.container.id , true ,tag)

        scannerFragment.setBarcodeScannerListener(this)

    }

    private fun resetBarcodeUI()
    {
        binding.etBarcode.setText("")

    }

    override fun onStart() {
        super.onStart()
        Log.e("Cashify_Temp", "onStart_Activity")

    }

    override fun onClick(v: View?)
    {
        onBarcodeScanned(binding.etBarcode.text.toString())

    }




    override fun onBarcodeScanned(barcode: String)
    {
        if(viewModel.isDeviceBarcode!!)
        {
            viewModel.deviceBarcode = barcode

            showStoreInHomeFragment(viewModel.fetchStorageDetailResponse!!,"home_device");
            Handler().postDelayed({ scannerFragment.resumeScanner() }, 500)

        }
        else
        {
            viewModel.trayBarcode = barcode

            handleFetchStorageDetails(barcode)
        }
    }

    private fun handleFetchStorageDetails(barcode: String)
    {
        viewModel.getDeviceStorage(barcode, object : OnResult<FetchStorageDetailsResponse> {
            override fun onResultAvailable(data: FetchStorageDetailsResponse) {
                if (data.isSuccess!!)
                {
                    showStoreInHomeFragment(data,"home_tray");
                     Handler().postDelayed({ scannerFragment.resumeScanner() }, 500)

                } else
                {
                    showError(data.errorMsg)
                    scannerFragment.resumeScanner()
                }
            }
        }, object : OnResult<Boolean> {
            override fun onResultAvailable(data: Boolean) {
                scannerFragment.resumeScanner()
            }
        })
    }

    private fun showStoreInHomeFragment(data: FetchStorageDetailsResponse ,fragmentTag :String)
    {
        viewModel.fetchStorageDetailResponse = data

        val fragment = StoreInHomeFragment.newInstance()
        mActivityHelper.addFragment(this, fragment,binding.container.id , true ,fragmentTag)
     }

    override fun showBarcode()
    {
        showBarcodeFragment("scanner_barcode")
    }

    override fun reLaunchActivity()
    {
        finish();
        startActivity(getIntent());
    }

    override fun popOutFragments()
    {
        var homeTray  : Fragment? = null
        var fragments = supportFragmentManager.fragments

        for(fragment in fragments)
        {
            if(fragment.tag.equals("scanner_barcode") || fragment.tag.equals("home_device"))
            {
                supportFragmentManager.popBackStack()
            }
            else if(fragment.tag.equals("home_tray"))
            {
                homeTray = fragment
            }

        }

        refreshStoreInFragment(homeTray)

    }

    private fun refreshStoreInFragment(fragment : Fragment?)
    {
        if(fragment != null)
        {
            var fragmentTransaction = supportFragmentManager.beginTransaction()
            fragmentTransaction.detach(fragment)
            fragmentTransaction.attach(fragment)
            fragmentTransaction.commit()

        }

    }

    override fun hideButtonLayout(hide: Boolean)
    {
        hideLayout(hide)
    }


    override fun hideLayout(hide : Boolean)
    {
        Log.e("Cashify_Temp", "hide")


        if(hide)
        {
            binding.llEtContainer.visibility = View.GONE
            binding.barcodeType.visibility = View.GONE
        }
        else
        {
            binding.llEtContainer.visibility = View.VISIBLE
            binding.barcodeType.visibility = View.VISIBLE
            binding.barcodeType.text = viewModel.barcodeHeading
        }
    }

    override fun onResume()
    {
        super.onResume()
        Log.e("Cashify_Temp", "onResume_Activity")

    }

    override fun onPause() {
        super.onPause()
        Log.e("Cashify_Temp", "onStart_Activity")

    }

    override fun onStop()
    {
        super.onStop()
        Log.e("Cashify_Temp", "onStop_Activity")

    }

    override fun onDestroy()
    {
        super.onDestroy()
        Log.e("Cashify_Temp", "onDestroy_Activity")

    }

    override fun onBackPressed()
    {

        if(supportFragmentManager.fragments.size == 1)
        {
            val intent = Intent(this, HomeActivity::class.java)
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)
        }
        else
        {
            super.onBackPressed()

        }



    }

}
