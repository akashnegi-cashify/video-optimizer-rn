package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.BuildConfig
import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityWippartInfoBinding
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.cashify.androidtrc.module.engineer.data.WipPartInfoctivityModel
import `in`.cashify.androidtrc.module.engineer.ui.fragment.ReturnReasonDialog
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.util.CommonConstant
import `in`.cashify.androidtrc.util.ImageUtil
import `in`.cashify.androidtrc.util.PermissionUtils
import android.Manifest
import android.content.Context
import android.content.DialogInterface
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.MediaStore
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.core.content.FileProvider
import androidx.core.content.PermissionChecker
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import java.io.File
import java.io.IOException

class WIPPartInfoActivity : BaseActivity(), View.OnClickListener, OnPartReturn {

    private val CAMERA_PIC_REQUEST = 1222
    private var mCurrentPhotoPath: String? = null
    private val REQ_CODE_RECEIVE_SCAN: Int = 103
    var mDeviceInfo: EngineerDeviceInfo? = null
    var partInfo: EngineerPartInfo? = null

    private val REQ_CODE_CONSUME_SCAN: Int = 101
    private val REQ_CODE_RETURN_SCAN: Int = 102

    private var barcode = ""
    private lateinit var viewModel: WipPartInfoctivityModel
    private lateinit var binding: ActivityWippartInfoBinding
    override fun getLayoutResId(): Int {
        return R.layout.activity_wippart_info
    }

    enum class RequestCode(val reqCode: Int) {
        CAMERA_PERMISSION_REQUEST(4)
    }

    val permissions = arrayOf(Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE)


    override fun onPartReturned(returnResponse: ReturnPartResponse) {
        if (returnResponse.isSucess) {
            showAlertDialog(
                "Part Returned",
                getString(R.string.ok),
                DialogInterface.OnClickListener { dialog, which -> finish() },
                null,
                null
            )
        } else {
            showError(returnResponse.errorMsg)
        }
    }


    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(WipPartInfoctivityModel::class.java)
        viewModel.activityListener = this
        mDeviceInfo = intent.getParcelableExtra(ViewPartActivity.KEY_DEVICE_INFO)
        partInfo = intent.getParcelableExtra(CommonConstant.KEY_PART_INFO)

        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        AnalyticsEventHelper.fireScreenEvent(
            this,
            AnalyticsController.AnalyticEventKey.EVENT_ONCREATE,
            AnalyticsController.AnalyticScreen.SCREEN_ENG_WIPE_PART,
            null,
            null,
            true
        )

        binding.btnReceive.setOnClickListener(this)
        binding.btnConsume.setOnClickListener(this)
        binding.btnCancel.setOnClickListener(this)
        binding.btnReturn.setOnClickListener(this)
        binding.tvDeviceBarcode.text = " ${mDeviceInfo?.deviceBarcode}"
        binding.tvDeviceStatus.text = "${mDeviceInfo?.status}"
        binding.tvDeviceProductTitle.text = "${mDeviceInfo?.productTitle}"


        binding.tvPartName.text = partInfo?.partName
        binding.tvPartBarcode.text = partInfo?.partBarcode
        binding.tvPartSku.text = partInfo?.partSku
        binding.tvPartStatus.text = partInfo?.status


        if (partInfo?.getPartStatus() == (PartStatus.OTHER)) {
            binding.tvPartStatus.setTextColor(binding.tvPartStatus.resources.getColor(R.color.black))
        } else if (partInfo?.getPartStatus() == (PartStatus.AVAILABBLE)
        ) {
            binding.tvPartStatus.setTextColor(binding.tvPartStatus.resources.getColor(R.color.teal))
        } else if (partInfo?.getPartStatus() == (PartStatus.NOT_AVAILABLE)
        ) {
            binding.tvPartStatus.setTextColor(binding.tvPartStatus.resources.getColor(R.color.red))
        }


        if (partInfo?.statusCode == CommonConstant.ALLOTED_STATUS_CODE ||
            partInfo?.statusCode == CommonConstant.RIDER_DELIVERY_PICKED_STATUS_CODE
        ) {
            binding.btnReceive.visibility = View.VISIBLE
        }

        if (partInfo?.statusCode == CommonConstant.REQUESTED_STATUS_CODE || partInfo?.statusCode == CommonConstant.AVAILABLE_STATUS_CODE
            || partInfo?.statusCode == CommonConstant.NOT_AVAILABLE_STATUS_CODE
        ) {
            binding.btnCancel.visibility = View.VISIBLE
        }


        if (partInfo?.statusCode == CommonConstant.RECEIVE_STATUS_CODE) {
            binding.btnConsume.visibility = View.VISIBLE
            binding.btnReturn.visibility = View.VISIBLE
        }

        viewModel.imageS3Link.observe(this, Observer { s3Url ->
            viewModel.consumePart(
                barcode,
                partInfo?.partId, partInfo?.prid,
                object : OnResult<Boolean> {
                    override fun onResultAvailable(data: Boolean) {
                        if (data) {
                            showAlertDialog(
                                resources.getString(R.string.part_consume),
                                getString(R.string.refresh),
                                object : DialogInterface.OnClickListener {
                                    override fun onClick(
                                        dialog: DialogInterface?,
                                        which: Int
                                    ) {
                                        finish()
//                                                        viewModel.getEngPartInfoList(mDeviceInfo?.deviceId?:"")
                                    }
                                },
                                null,
                                null
                            )

                        }
                    }
                }, s3Url
            )
            /* val dialogFragment = ImageViewDialog.newInstance(s3Url)
             var ft = supportFragmentManager.beginTransaction()
             var prev = supportFragmentManager.findFragmentByTag("dialog")
             if (prev != null) {
                 ft.remove(prev)
             }
             ft.addToBackStack(null)
             dialogFragment.show(ft, "dialog")*/
        })
    }


    protected fun hasCameraPermission(): Boolean {
        val hasPermission = canAccessCamera(this)
        if (!hasPermission && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            PermissionUtils.requestPermissions(this, permissions, RequestCode.CAMERA_PERMISSION_REQUEST.reqCode)
        }
        return hasPermission
    }

    private fun canAccessCamera(ctx: Context): Boolean {
        return PermissionChecker
            .checkSelfPermission(ctx, Manifest.permission.CAMERA) ==
                PermissionChecker.PERMISSION_GRANTED
    }

    private fun dispatchTakePictureIntent() {

        if (!hasCameraPermission()) {
            return
        }
        val takePictureIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        if (takePictureIntent.resolveActivity(this.packageManager) != null) {
            val photoFile: File? = try {
                createImageFile()
            } catch (ex: IOException) {
                ex.printStackTrace()
                return
            }
            if (photoFile != null) {
                val photoURI = FileProvider.getUriForFile(
                    applicationContext,
                    BuildConfig.APPLICATION_ID + ".provider",
                    photoFile
                )
                takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT, photoURI)
                startActivityForResult(takePictureIntent, CAMERA_PIC_REQUEST)
            }
        }
    }


    @Throws(IOException::class)
    private fun createImageFile(): File? {
        val imageFileName = "IMG_" + "_" + System.currentTimeMillis() + "_"
        val storageDir = this.getExternalFilesDir(Environment.DIRECTORY_PICTURES)
        val image = File.createTempFile(
            imageFileName,  /* prefix */
            ".jpg",  /* suffix */
            storageDir /* directory */
        )
        mCurrentPhotoPath = image.absolutePath
        return image
    }


    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.btn_receive -> {


                getConfirmationPopUp()
            }
            R.id.btn_consume -> {

                if (partInfo?.isBulk ?: false) {

                    consumePart(partInfo?.partBarcode)
                } else {
                    startActivityForResult(
                        Intent(
                            this,
                            EngineerViewPartScannerActivity::class.java
                        ).apply {
                            putExtra("name", partInfo?.deviceName)
                            putExtra("barcode", partInfo?.partBarcode)
                        }, REQ_CODE_CONSUME_SCAN
                    )
                }


            }
            R.id.btn_cancel -> {
                getCancelConfirmationPopUp()


            }
            R.id.btn_return -> {

                if (partInfo?.isBulk ?: false) {
                    returnPart(partInfo?.partBarcode)
                } else {

                    startActivityForResult(Intent(this, EngineerViewPartScannerActivity::class.java).apply {
                        putExtra("name", partInfo?.deviceName)
                        putExtra("barcode", partInfo?.partBarcode)
                    }, REQ_CODE_RETURN_SCAN)
                }


            }

        }
    }

    private fun getCancelConfirmationPopUp() {
        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
            alertDialog.dismiss()

            viewModel?.cancelPart(
                object : OnResult<CancelPartResponse> {
                    override fun onResultAvailable(data: CancelPartResponse) {
                        if (data.success) {


                            cancelSuccessDialog()
                        } else {
                            viewModel?.activityListener!!.showError(data.errorMsg)
                        }


                    }
                }, partInfo?.prid.toString()
            )


        }

        message.text = resources.getString(R.string.click_on_confirm_to_cancel)
        confirm.text = resources.getString(R.string.confirm)

        alertDialog.show()

    }

    fun cancelSuccessDialog() {
        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val tv1 = dialogView.findViewById(R.id.tv1) as TextView
        val tv2 = dialogView.findViewById(R.id.tv2) as TextView
        tv1.visibility = View.VISIBLE
        tv2.visibility = View.VISIBLE

        message.text = "Part request for part name"
        tv1.text = partInfo?.partName.toString()
        tv2.text = "is successfully cancelled"

        cancel.visibility = View.INVISIBLE
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            finish()
        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
            finish()
        }


        confirm.text = resources.getString(R.string.ok)

        alertDialog.show()
    }


    private fun consumePart(barcode: String?) {

        if (barcode != null && barcode.equals(partInfo?.partBarcode, true)) {
            showAlertDialog(
                resources.getString(R.string.r_u_sure_u_want_to_consume),
                resources.getString(R.string.yes),
                object : DialogInterface.OnClickListener {

                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        this@WIPPartInfoActivity.barcode = barcode
                        dispatchTakePictureIntent()
                    }
                },
                "Cancel",
                null
            )

        } else {
            showError(resources.getString(R.string.barcode_does_not))
        }
    }


    private fun returnPart(barcode: String?) {
        if (barcode != null && barcode.equals(partInfo?.partBarcode)) {

            viewModel.returnPartReason(object : OnResult<ReturnReasonList?> {
                override fun onResultAvailable(data: ReturnReasonList?) {
                    showBottomDialog(
                        this@WIPPartInfoActivity,
                        ReturnReasonDialog.newInstance(partInfo, data),
                        "ReturnReasonDialog"
                    )
                }
            })
        } else {
            showError(resources.getString(R.string.barcode_does_not))
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {

        if (requestCode == REQ_CODE_CONSUME_SCAN && resultCode == RESULT_OK) {
            consumePart(data?.getStringExtra("barcode"))
            return
        } else if (requestCode == REQ_CODE_RETURN_SCAN && resultCode == RESULT_OK) {
            returnPart(data?.getStringExtra("barcode"))


            return
        } else if (requestCode == REQ_CODE_RECEIVE_SCAN && resultCode == RESULT_OK) {
            finish()


            return
        }

        if (requestCode == CAMERA_PIC_REQUEST && resultCode == RESULT_OK) {
            if (!mCurrentPhotoPath.isNullOrEmpty()) {
                val imageUri = Uri.parse(mCurrentPhotoPath)
                val compressedImg = imageUri?.path?.let { ImageUtil.compressImage(it) }
                compressedImg?.let { viewModel.performUpload(it) }
            }
        }

        super.onActivityResult(requestCode, resultCode, data)
    }


    private fun getConfirmationPopUp() {//show confirmation pop up and make a request to server
        if (partInfo?.isBulk ?: false) {
            viewModel.activityListener?.showDialog(
                "",
                resources.getString(R.string.are_u_sure),
                resources.getString(R.string.yes),
                object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        viewModel.getReceivePartByEngineer(
                            object : OnResult<ReceivedPartResponse> {
                                override fun onResultAvailable(data: ReceivedPartResponse) {
                                    if (data.success) {

                                        receiveSuccessDialog()


                                    } else {
                                        viewModel.activityListener?.showError(data.errorMsg)
                                    }
                                }
                            }, partInfo?.partId ?: "", "", partInfo?.prid.toString()
                        )
                    }
                },
                "No",
                object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        dialog?.dismiss()
                    }
                })
        }
//            //show barcode scanner and make a request to server
        else {

            val intent = Intent(
                this,
                ScanAllowedPartsActivity::class.java
            ).apply {

                putExtra("prid", partInfo?.prid.toString())
            }
            startActivityForResult(
                intent,
                REQ_CODE_RECEIVE_SCAN
            )

        }

    }


    private fun receiveSuccessDialog() {
        viewModel.activityListener?.showDialog(
            "",
            String.format(resources.getString(R.string.part_successfully_received), partInfo?.partName),
            resources.getString(R.string.yes),
            object : DialogInterface.OnClickListener {
                override fun onClick(dialog: DialogInterface?, which: Int) {
                    dialog?.dismiss()
                    finish()
                }
            },
            "",
            object : DialogInterface.OnClickListener {
                override fun onClick(dialog: DialogInterface?, which: Int) {
                    dialog?.dismiss()
                    finish()
                }
            })


    }


}