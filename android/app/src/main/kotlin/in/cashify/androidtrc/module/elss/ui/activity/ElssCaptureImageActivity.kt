package `in`.cashify.androidtrc.module.elss.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityElssCaptureImageBinding
import `in`.cashify.androidtrc.module.elss.adapter.ElssCaptureImageAdapter
import `in`.cashify.androidtrc.module.elss.data.ElssCaptureImageViewModel
import `in`.cashify.androidtrc.util.ImageUtil
import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.LinearLayout
import androidx.core.content.ContextCompat
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.GridLayoutManager

class ElssCaptureImageActivity : BaseActivity(), View.OnClickListener,
    ElssCaptureImageAdapter.OnImageClickListener {
    private lateinit var binding: ActivityElssCaptureImageBinding
//    private lateinit var viewModel: ElssViewModel


    private val REQUEST_CODE_CAMERA = 101
    private val PERMISSION_REQUEST_CODE_CAMERA = 102
    private var selectedPos = 0
    private var imagePath: String? = ""


    private var imagePathList = arrayListOf<String>()
    var viewModel: ElssCaptureImageViewModel? = null
    override fun getLayoutResId(): Int {
        return R.layout.activity_elss_capture_image
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(ElssCaptureImageViewModel::class.java)
        binding.lifecycleOwner = this
        viewModel?.activityListener = this


        setSupportActionBar(binding.toolbar)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ELSS_CAPTURE_IMAGE, null, null, true)

        if (supportActionBar != null) {
            supportActionBar?.setDisplayHomeAsUpEnabled(true)
            supportActionBar?.setDisplayShowHomeEnabled(true)
            supportActionBar?.title = "Capture Images"
        }


        if (intent.getStringArrayListExtra("list") == null) {
            for (i in 1..6) {
                imagePathList.add("")

            }
        } else {
            // if user has already uploaded the images
            imagePathList = intent.getStringArrayListExtra("list")!!
            if (imagePathList.size < 6) {
                for (i in imagePathList.size+1..6)

                    imagePathList.add("")
            }

        }

        viewModel = ViewModelProvider(this).get(ElssCaptureImageViewModel::class.java)
        binding.recycleImage.layoutManager = GridLayoutManager(this, 3)
//            LinearLayoutManager(this)
        //GridLayoutManager(this , 3)
        binding.recycleImage.adapter = ElssCaptureImageAdapter(imagePathList, this)
        binding.btnDone.setOnClickListener {

            viewModel?.mFilePathList?.clear()
            viewModel?.s3PathList?.clear()
            imagePathList.forEach {
                if (!TextUtils.isEmpty(it)) {
                    viewModel?.mFilePathList?.add(it)
//                    mActivityHelper.showSnackBar(this , resources.getString(R.string.plz_upload_all_images) , Style.ALERT, null)

                }


            }

            if (viewModel?.mFilePathList != null && viewModel?.mFilePathList?.size!! > 0) {
                viewModel?.performUpload()
            } else {
                finish()
            }
        }



        viewModel?.s3UploadSuccessful?.observe(this, androidx.lifecycle.Observer {
            val i = Intent()
            i.putExtra("list", viewModel?.s3PathList)
            i.putExtra("sku", intent.getStringExtra("sku"))
            setResult(Activity.RESULT_OK, i)
            finish()

        })


    }

    override fun onClick(v: View?) {

    }


    override fun onImageClick(pos: Int) {
        selectedPos = pos
        openCamera(REQUEST_CODE_CAMERA, PERMISSION_REQUEST_CODE_CAMERA)


    }


    fun openCamera(requestCode: Int, permissionRequestCode: Int) {

        if (ContextCompat.checkSelfPermission(
                this, Manifest.permission.CAMERA
            ) == PackageManager.PERMISSION_GRANTED && ContextCompat.checkSelfPermission(
                this, Manifest.permission.WRITE_EXTERNAL_STORAGE
            ) == PackageManager.PERMISSION_GRANTED
        ) {

            imagePath =
                ImageUtil.launchCamera(this, ImageUtil.fileNameByTime, requestCode)


        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                requestPermissions(
                    arrayOf(Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE),
                    permissionRequestCode
                )
            }
        }


    }


    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        grantResults.forEach {
            if (it != PackageManager.PERMISSION_GRANTED) {
                return@onRequestPermissionsResult
            }
        }

        if (requestCode == PERMISSION_REQUEST_CODE_CAMERA) {
            openCamera(REQUEST_CODE_CAMERA, PERMISSION_REQUEST_CODE_CAMERA)
        }


    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_CAMERA) {
            if (resultCode == Activity.RESULT_OK) {
                imagePathList.set(selectedPos, imagePath.toString())
                binding.recycleImage.adapter?.notifyDataSetChanged()
            }
        }
    }


    override fun hasActionBar(): Boolean {
        return false
    }
}