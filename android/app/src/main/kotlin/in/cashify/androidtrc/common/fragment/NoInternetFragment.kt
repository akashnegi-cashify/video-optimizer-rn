package `in`.cashify.androidtrc.common.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentNoInternetBinding
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil

class NoInternetFragment : BaseFragment() {

    private lateinit var binding: FragmentNoInternetBinding

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {

        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_no_internet,
            container,
            false
        )

        return binding.root
    }

    companion object {
        fun newInstance() = NoInternetFragment()

    }


}
