package `in`.cashify.androidtrc.module.storageManager.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityStoreOutBinding
import `in`.cashify.androidtrc.module.elss.api.response.ElssDeviceResponse
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.module.storageManager.data.StorageOutActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreOutHomeFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreOutScanFragment
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Handler
import android.util.Log
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class StoreOutActivity : BaseActivity(), View.OnClickListener, StorageOutActivityListener ,BarcodeScannerFragment.BarcodeScannerListener
{

    private lateinit var binding: ActivityStoreOutBinding
    private lateinit var viewModel: StoreOutViewMadel
    private lateinit var scannerFragment: BarcodeScannerFragment


    override fun getLayoutResId(): Int
    {
        return R.layout.activity_store_out
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    )
    {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(StoreOutViewMadel::class.java)
        binding.lifecycleOwner = this

        viewModel.activityListener = this

        viewModel.storeOutActivityListener = this

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_STORE_OUT, null, null, true)

        val fragment = StoreOutHomeFragment.newInstance()
         mActivityHelper.addFragment(this, fragment, binding.container.id, true)

        binding.btnSubmitBarcode.setOnClickListener(this)
        binding.barcodeType.text = "Device Barcode"


        setTitle("Device Store Out")




    }
    override fun onClick(v: View?)
    {
        onBarcodeScanned(binding.etBarcode.text.toString())
    }

    override fun showStoreOutFragment()
    {
        binding.llEtContainer.visibility = View.VISIBLE

        val fragment = BarcodeScannerFragment.newInstance(true, false)
        mActivityHelper.addFragment(this, fragment,binding.container.id , true)

        fragment.setBarcodeScannerListener(this)



    }

    override fun onResume()
    {
        super.onResume()

    }

    override fun reLaunchActivity()
    {
        finish();
        startActivity(getIntent());
    }

    override fun hideButtonLayout(hide: Boolean)
    {
        hideLayou(hide)
     }

    override fun onBarcodeScanned(barcode: String)
    {

        viewModel.barcode = barcode
        val fragment = StoreOutScanFragment.newInstance()
        mActivityHelper.addFragment(this, fragment,binding.container.id , true)

    }

    override fun hideLayout(show: Boolean) {
        hideLayou(show)
    }

    fun hideLayou(hide : Boolean)
    {
        Log.e("Cashify_Temp", "hide")


        if(hide)
        {
            binding.llEtContainer.visibility = View.GONE
            binding.barcodeType.visibility = View.GONE
            if(supportFragmentManager.fragments.size == 0)
                finish()

        }
        else
        {
            binding.llEtContainer.visibility = View.VISIBLE
            binding.barcodeType.visibility = View.VISIBLE
        }
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
