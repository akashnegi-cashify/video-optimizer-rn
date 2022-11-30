package `in`.cashify.androidtrc.module.elss.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.adapter.ElssDevicePartAdapter
import `in`.cashify.androidtrc.module.elss.data.OnPartAdded
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.*
import android.widget.Button
import android.widget.EditText
import android.widget.ProgressBar
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.util.*


/**
 * Created by Avaneesh Maurya on 31,Agust,2019
 */
class ElssAddPartDialog : DialogFragment(), View.OnClickListener {

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.btn_request -> {
                val partForOrder = elssDevicePartAdapter?.getPartForOrder()
                onPartAdded?.onPartAdded(partForOrder)
                dismissAllowingStateLoss()
            }

            R.id.btn_cancel -> {
                dismissAllowingStateLoss()
            }
        }
    }

    private var mProgressBar: ProgressBar? = null
    private var mPartList: ArrayList<DevicePartInfo>? = null
    private var mSearchPartList: ArrayList<DevicePartInfo>? = null
    var elssDevicePartAdapter: ElssDevicePartAdapter? = null
    var onPartAdded: OnPartAdded? = null
    var mEtSearch: EditText? = null

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = super.onCreateDialog(savedInstanceState)
        dialog.window?.apply {
            requestFeature(Window.FEATURE_NO_TITLE)
        }
        return dialog
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is OnPartAdded) {
            onPartAdded = context
        }
    }

    override fun onStart() {
        super.onStart()
        dialog?.window?.apply {
            setGravity(Gravity.BOTTOM)
            attributes?.windowAnimations = R.style.DialogUpDownAnimation
            setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPartList = arguments?.getParcelableArrayList<DevicePartInfo>(KEY_PART_LIST)
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        dialog?.window?.apply {
            setGravity(Gravity.BOTTOM)
//            isCancelable = false
            attributes?.windowAnimations = R.style.DialogUpDownAnimation
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.dialog_elss_add_part, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        view.findViewById<Button>(R.id.btn_request).setOnClickListener(this)
        view.findViewById<Button>(R.id.btn_cancel).setOnClickListener(this)
        mProgressBar = view.findViewById(R.id.pb_progress)
        mEtSearch = view.findViewById(R.id.et_search_view)
        elssDevicePartAdapter = ElssDevicePartAdapter()
        val recyclerView = view.findViewById<RecyclerView>(R.id.rv_parts)
        recyclerView.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false) as RecyclerView.LayoutManager?
        recyclerView.adapter = elssDevicePartAdapter
        elssDevicePartAdapter?.changeDataSet(mPartList)
        mEtSearch?.addTextChangedListener(textWatcher)
    }

    private fun filterList(searchQuery: String) {
        if (mPartList == null) {
            return
        }
        if (searchQuery.isEmpty()) {
            mSearchPartList = mPartList
        } else {
            mSearchPartList = ArrayList()
            for (part in mPartList!!) {
                if (part.partName != null) {

                    if (part.partName!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        mSearchPartList?.add(part)
                        continue
                    }
                }

                if (part.partSku != null) {

                    if (part.partSku!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        mSearchPartList?.add(part)
                        continue
                    }
                }

            }
        }
        elssDevicePartAdapter?.changeDataSet(mSearchPartList)
        mEtSearch?.clearFocus()
    }

    private var textWatcher: TextWatcher = object : TextWatcher {
        override fun afterTextChanged(s: Editable) {
            filterList(s.toString())
        }

        override fun beforeTextChanged(
            s: CharSequence,
            start: Int,
            count: Int,
            after: Int
        ) {
        }

        override fun onTextChanged(
            s: CharSequence,
            start: Int,
            before: Int,
            count: Int
        ) {
        }
    }

    companion object {
        const val KEY_PART_LIST = "key_part_info"
        fun newInstance(
            partList: ArrayList<DevicePartInfo>?
        ): ElssAddPartDialog {
            val args = Bundle()
            args.putParcelableArrayList(KEY_PART_LIST, partList)
            val dialog = ElssAddPartDialog()
            dialog.arguments = args
            return dialog
        }
    }



}