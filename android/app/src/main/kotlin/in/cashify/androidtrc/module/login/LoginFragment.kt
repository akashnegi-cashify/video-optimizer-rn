package `in`.cashify.androidtrc.module.login

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentLoginBinding
import `in`.cashify.androidtrc.module.login.data.LoginProcessListener
import `in`.cashify.androidtrc.module.login.data.LoginViewModelV2
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil


/**
 * Created by Avaneesh Maurya on 19,July,2019
 */
class LoginFragment : BaseFragment() {

    lateinit var binding: FragmentLoginBinding
    lateinit var loginProcessListener: LoginProcessListener

    companion object {
        fun newInstance(): LoginFragment {
            val args = Bundle()
            val fragment = LoginFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_login, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(LoginViewModelV2::class.java)
        binding.loginModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        if (binding.loginModel == null) {
            return
        }
        binding.loginModel?.loginProcessListener = loginProcessListener

    }

    override fun onAttach(context: Context) {
//        AndroidSupportInjection.inject(this)
        super.onAttach(context)
        if (context is LoginProcessListener) {
            loginProcessListener = context
        }

    }
}