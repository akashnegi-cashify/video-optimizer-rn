package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.databinding.FragmentMarkOkListBinding
import `in`.cashify.androidtrc.module.runner.adapter.MarkOkListAdapter
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.EngineerMarkOkDevice
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class MarkOkListFragment : DialogFragment() {

    lateinit var binding: FragmentMarkOkListBinding
    var markOkList: EngineerMarkOkDevice? = null

    companion object {

        const val TAG: String = "MarkOkListFragment"
        const val KEY_MARK_OK_LIST = "mark_ok_list"

        fun newInstance(markOkList: EngineerMarkOkDevice?): MarkOkListFragment {
            val argument = Bundle()
            argument.putParcelable(KEY_MARK_OK_LIST, markOkList)
            val fragment = MarkOkListFragment()
            fragment.arguments = argument
            return fragment

        }
    }

    override fun onStart() {
        super.onStart()
        val dialog = dialog
        if (dialog != null) {
            val width = ViewGroup.LayoutParams.MATCH_PARENT
            val height = ViewGroup.LayoutParams.MATCH_PARENT
            val window = dialog.window

            window?.setLayout(width, height)
        }
    }

    override fun onDestroyView() {
        if (dialog != null && retainInstance) {
            dialog?.setDismissMessage(null)
        }
        super.onDestroyView()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        markOkList = arguments?.getParcelable(KEY_MARK_OK_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_mark_ok_list, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        val markOkListAdapter = MarkOkListAdapter()
        binding.rvDevices.adapter = markOkListAdapter
        markOkListAdapter.changeDatSet(markOkList)
    }

}