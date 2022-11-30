package `in`.cashify.androidtrc.module.login

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentLoginOtpBinding
import `in`.cashify.androidtrc.module.login.data.LoginViewModelV2
import `in`.cashify.androidtrc.module.login.data.OtpVerificationData
import `in`.cashify.androidtrc.util.Validation
import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.text.InputType
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import androidx.appcompat.app.AppCompatActivity
import androidx.databinding.DataBindingUtil
import dagger.android.support.DaggerAppCompatActivity

class LoginOtpVerificationFragment : BaseFragment() {
    private val REQUESTCODE_SCAN: Int = 101
    lateinit var binding: FragmentLoginOtpBinding
    private var isPasswordShown = false
    private var activityViewModel: LoginViewModelV2? = null


    companion object {

        fun newInstance(): LoginOtpVerificationFragment {
            var args = Bundle()
            val otpFragment = LoginOtpVerificationFragment()
            return otpFragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_login_otp, container, false)
        return binding.root
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        activityViewModel = getActivityViewModel(LoginViewModelV2::class.java)
        binding.loginModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        binding.etOtp.setOnTouchListener(object : View.OnTouchListener {
            override fun onTouch(v: View?, event: MotionEvent?): Boolean {

                val DRAWABLE_RIGHT = 2

                if (event != null) {
                    if (event.action == MotionEvent.ACTION_UP && event.rawX >= (binding.etOtp.right - binding.etOtp.compoundDrawables[DRAWABLE_RIGHT].bounds.width())) {
                        if (!isPasswordShown) {
                            isPasswordShown = true
                            binding.etOtp.setCompoundDrawablesWithIntrinsicBounds(
                                0,
                                0,
                                android.R.drawable.ic_partial_secure,
                                0
                            )
                            binding.etOtp.transformationMethod =
                                HideReturnsTransformationMethod.getInstance()
                        } else {
                            isPasswordShown = false
                            binding.etOtp.setCompoundDrawablesWithIntrinsicBounds(
                                0,
                                0,
                                android.R.drawable.ic_secure,
                                0
                            )
                            binding.etOtp.transformationMethod =
                                PasswordTransformationMethod.getInstance()
                        }


                        return true;
                    }
                }
                return false;
            }
        })




        binding.etLocation.setOnTouchListener(object : View.OnTouchListener {
            override fun onTouch(v: View?, event: MotionEvent?): Boolean {

                val DRAWABLE_RIGHT = 2

                if (event != null) {
                    if (event.action == MotionEvent.ACTION_UP && event.rawX >= (binding.etOtp.right - (binding.etOtp.compoundDrawables[DRAWABLE_RIGHT].bounds.width() + resources.getDimension(
                            R.dimen.space_10dp
                        )))
                    ) {

                        startActivityForResult(
                            Intent(activity, ScanLocationActivity::class.java),
                            REQUESTCODE_SCAN
                        )



                        return true;
                    }
                }
                return false;
            }
        })
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUESTCODE_SCAN && resultCode == AppCompatActivity.RESULT_OK) {
            activityViewModel?.location?.value = data?.getStringExtra("loc")
            activityViewModel?.clickLogin()
        }
    }

}
