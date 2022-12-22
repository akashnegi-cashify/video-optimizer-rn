package `in`.cashify.androidtrc.module.storageManager.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityStoreOutBinding
import `in`.cashify.androidtrc.databinding.ActivityVirtualStoreBinding
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.module.storageManager.data.StorageOutActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.data.VirtualStoreActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.VirtualStoreViewModel
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreOutHomeFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.VirtualStoreFragment
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.LinearLayout
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

import kotlinx.android.synthetic.main.activity_virtual_store.*

class VirtualStore : BaseActivity(), View.OnClickListener ,
    BarcodeScannerFragment.BarcodeScannerListener,StorageOutActivityListener
{

    private lateinit var binding: ActivityVirtualStoreBinding
    private lateinit var viewModel: VirtualStoreViewModel
    private lateinit var scannerFragment: BarcodeScannerFragment

    override fun getLayoutResId(): Int
    {
        return R.layout.activity_virtual_store
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(VirtualStoreViewModel::class.java)
        binding.lifecycleOwner = this

        viewModel.activityListener = this
        viewModel.storeOutActivityListener = this

        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        mActivityHelper.addFragment(this, scannerFragment,binding.container.id , true )

        scannerFragment.setBarcodeScannerListener(this)
        binding.btnSubmitBarcode.setOnClickListener(this)

        binding.barcodeType.text = "Device Barcode"




    }

    override fun onClick(v: View?)
    {
        onBarcodeScanned(binding.etBarcode.text.toString())
    }



    override fun onBarcodeScanned(barcode: String)
    {
        scannerFragment.pauseScanner()

        viewModel.barcode = barcode
        val fragment = VirtualStoreFragment.newInstance()
        mActivityHelper.addFragment(this, fragment,binding.container.id , true)
    }

    override fun hideLayout(show: Boolean)
    {
        hideLayou(show)
     }

    fun hideLayou(hide : Boolean)
    {
        Log.e("Cashify_Temp", "hide")


        if(hide)
        {
            binding.llEtContainer.visibility = View.GONE
            if(supportFragmentManager.fragments.size == 0)
                finish()
        }
        else
        {
            binding.llEtContainer.visibility = View.VISIBLE
        }
    }

    override fun showStoreOutFragment()
    {

    }


    override fun reLaunchActivity()
    {
        finish();
        startActivity(getIntent());
    }

    override fun hideButtonLayout(hide: Boolean) {
        if(hide) {
            binding.llEtContainer.visibility = View.GONE
            binding.barcodeType.visibility = View.GONE

        }
        else
        {
            binding.llEtContainer.visibility = View.VISIBLE
            binding.barcodeType.visibility = View.VISIBLE

        }    }

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
