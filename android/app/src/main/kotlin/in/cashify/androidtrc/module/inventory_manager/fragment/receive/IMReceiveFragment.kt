package `in`.cashify.androidtrc.module.inventory_manager.fragment.receive

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentIMReceiveBinding
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [IMReceiveFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class IMReceiveFragment : BaseFragment() {
    // TODO: Rename and change types of parameters
   var binding: FragmentIMReceiveBinding? = null

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
binding  = DataBindingUtil.inflate(inflater , R.layout.fragment_i_m_receive, container, false)


       binding?.btnScanAgain?.setOnClickListener {
           startActivity(Intent(activity , IMReceiveScanAcitity::class.java))

       }

        return binding?.root
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMReceiveFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMReceiveFragment().apply {

            }
    }
}