package `in`.cashify.androidtrc.module.engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentSelfAssignPartBinding
import `in`.cashify.androidtrc.module.engineer.data.SelfAssignViewModel
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.core.content.res.ResourcesCompat
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import de.keyboardsurfer.android.widget.crouton.Style


class SelfAssignPartFragment : BaseFragment() {


    lateinit var binding: FragmentSelfAssignPartBinding
    var activityViewModel: SelfAssignViewModel? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_self_assign_part, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        activityViewModel = getActivityViewModel(SelfAssignViewModel::class.java)
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner


        activityViewModel?.partBarcode?.value = ""
        activityViewModel?.deviceBarcode?.value = ""
        activityViewModel?.replcaePartResponse?.value = null

        activityViewModel?.partBarcode?.observe(viewLifecycleOwner, Observer {
            binding.etPart.setText(it)
        })


        activityViewModel?.deviceBarcode?.observe(viewLifecycleOwner, Observer {
            binding.etDevice.setText(it)
        })


        activityViewModel?.replcaePartResponse?.observe(viewLifecycleOwner, Observer {
            if (it != null) {
                showReplacePartSuccessful(binding.etPart.text.toString())
            }

            binding.etPart.text.clear()
            binding.etDevice.text.clear()
        })

        binding.btnSubmit.setOnClickListener {
            if (binding.etPart.text.trim().toString().isEmpty()) {
                mActivityHelper.showSnackBar(
                    activity,
                    resources.getString(R.string.enter_part_barcode),
                    Style.ALERT,
                    null
                )
                return@setOnClickListener
            }

            if (binding.etDevice.text.trim().toString().isEmpty()) {
                mActivityHelper.showSnackBar(
                    activity,
                    resources.getString(R.string.enter_device_barcode),
                    Style.ALERT,
                    null
                )
                return@setOnClickListener
            }
            showConfirmReplaceDialog(binding.etPart.text.toString())
        }

        binding.btnScanDeviceBarcode.setOnClickListener {

            activityViewModel?.openDeviceBarcodeScanFragment?.value = true
        }

        binding.btnScanPartBarcode.setOnClickListener {
            activityViewModel?.openPartBarcodeScanFragment?.value = true
        }


    }


    companion object {

        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            SelfAssignPartFragment().apply {
//                arguments = Bundle().apply {
//                    putString(ARG_PARAM1, param1)
//                    putString(ARG_PARAM2, param2)
//                }
            }
    }


    fun showConfirmReplaceDialog(
        partName: String?
    ) {

        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val alertDialog = builder.create()
        val typeface = ResourcesCompat.getFont(activity!!, R.font.montserrat_medium)
        message.typeface = typeface
        message.text = resources.getString(R.string.click_on_confirm_to_recieve) + " " + partName
        confirm.text = resources.getString(R.string.confirm)


        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        confirm.setOnClickListener {
            activityViewModel?.replaceParts(
                binding.etPart.text.toString(),
                binding.etDevice.text.toString()
            )
            alertDialog.dismiss()


        }


        alertDialog.show()


    }


    fun showReplacePartSuccessful(
        partName: String?
    ) {


        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)

        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)
        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val alertDialog = builder.create()
        val typeface = ResourcesCompat.getFont(activity!!, R.font.montserrat_medium)
        message.typeface = typeface
        message.text = "Part " + partName + " is \nsuccessfully assigned"

        confirm.text = resources.getString(R.string.ok)


        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        confirm.setOnClickListener {
//            activityViewModel?.replaceParts(binding.etPart.text.toString(), binding.etDevice.text.toString())
            alertDialog.dismiss()


        }


        alertDialog.show()


    }





}