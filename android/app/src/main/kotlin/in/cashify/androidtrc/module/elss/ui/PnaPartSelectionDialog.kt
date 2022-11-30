package `in`.cashify.androidtrc.module.elss.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.adapter.SkuPartPnaAdapter
import `in`.cashify.androidtrc.module.elss.api.response.ElssPart
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import android.app.Activity
import android.app.AlertDialog
import android.app.DialogFragment
import android.content.Context
import android.content.DialogInterface
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.snackbar.Snackbar
import kotlinx.android.synthetic.main.dialog_send_to_tl.*
import okhttp3.internal.filterList
import java.io.Serializable

class PnaPartSelectionDialog : DialogFragment() {

    var empty=false
    var selection=false
   var partList:ArrayList<ElssPart>?=null
   var activity:ElssPartSelectionActivity? =null

    override fun onAttach(activity: Activity?) {
        this.activity=activity as ElssPartSelectionActivity
        super.onAttach(activity)
    }
    override fun onCreate(savedInstanceState: Bundle?) {
         partList = arguments.getSerializable(LIST) as ArrayList<ElssPart>?
        super.onCreate(savedInstanceState)
    }

    override fun onCreateView(inflater: LayoutInflater?, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        var view =inflater?.inflate(R.layout.pna_part_selection_dialog, container, false)
        isCancelable=false
        return view
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupClickListeners(view)
        var rvParts=view.findViewById<RecyclerView>(R.id.rv_pna_parts)
        var tvNoParts=view.findViewById<TextView>(R.id.tv_no_parts)

        rvParts.setLayoutManager(LinearLayoutManager(activity, LinearLayoutManager.VERTICAL, false))
        rvParts.adapter = partList?.let { SkuPartPnaAdapter(it, activity as ElssPartSelectionActivity ) }

        partList?.forEach { item->
            if(item.isVisibleForPna){
                empty=true
            }
        }

        if(empty){
            tvNoParts.visibility=View.GONE
        }else{
            tvNoParts.visibility=View.VISIBLE
        }
    }

    override fun onStart() {
        super.onStart()
        dialog?.window?.setLayout(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.WRAP_CONTENT
        )
    }


    private fun setupClickListeners(view: View) {

        view.findViewById<Button>(R.id.btn_cancel).setOnClickListener{
            (activity as ElssPartSelectionActivity).isPNAPartSelectionApplied=null
            (activity as ElssPartSelectionActivity).viewModel.adapter?.elssRequest?.repairPartList?.forEach {
               it.isPnaSelected=false
            }
            getDialog().dismiss()
        }
        view.findViewById<Button>(R.id.btn_okay).setOnClickListener {
            okayBtnPress()
        }
    }


    fun okayBtnPress(){
        selection=false
        for (item in partList!!) {
            if (item.isPnaSelected) {
                selection=true
                break
            }
        }

        if(selection){
            showAlert()
        }else{
            Toast.makeText((activity as ElssPartSelectionActivity),"No Part Selected",Toast.LENGTH_LONG).show()
        }
    }


    private fun showAlert(){

        val dialogBuilder = AlertDialog.Builder(activity)

        // set message of alert dialog
        dialogBuilder.setMessage(activity?.getString(R.string.msg_part_pna_apply))
            // if the dialog is cancelable
            .setCancelable(false)
            // positive button text and action
            .setPositiveButton(activity?.getString(R.string.proceed_to_login), DialogInterface.OnClickListener {
                    dialog, id ->
                dialog.cancel()
                getDialog().dismiss()
                activity?.onProceedClick()

            })
            // negative button text and action
            .setNegativeButton(activity?.getString(R.string.cancel), DialogInterface.OnClickListener {
                    dialog, id -> dialog.cancel()
            })

        // create dialog box
        val alert = dialogBuilder.create()
        // set title for alert dialog box
        alert.setTitle("Alert !")
        // show alert dialog
        alert.show()
    }

    companion object {
        private const val LIST = "Partlist"
        fun newInstance(items: List<ElssPart>?): PnaPartSelectionDialog {
            val multiSelectExpandableFragment = PnaPartSelectionDialog()
            val args = Bundle()
            args.putSerializable(
                LIST,
                items as Serializable?
            )
            multiSelectExpandableFragment.arguments = args
            return multiSelectExpandableFragment
        }
    }
}

interface ProceedClickDialogImpl{

    fun onProceedClick()
}

