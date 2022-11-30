package `in`.cashify.androidtrc.module.login

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.BaseAPICallback
import `in`.cashify.androidtrc.databinding.ActivityChangePasswordBinding
import `in`.cashify.androidtrc.module.login.api.ChangePasswordRequest
import `in`.cashify.androidtrc.module.login.api.ChangePasswordResponse
import `in`.cashify.androidtrc.module.login.api.LoginModuleApi
import `in`.reglobe.api.kotlin.exception.APIException
import android.content.DialogInterface
import android.os.Bundle
import android.text.TextUtils
import android.text.method.HideReturnsTransformationMethod
import android.text.method.PasswordTransformationMethod
import android.view.View
import android.widget.CompoundButton
import android.widget.EditText
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import kotlinx.coroutines.Deferred
import okhttp3.Response


/**
 * Created by Avaneesh Maurya on 17,January,2020
 */
class ChangePasswordActivity : BaseActivity(), View.OnClickListener,
    CompoundButton.OnCheckedChangeListener {
    override fun getLayoutResId(): Int {
        return R.layout.activity_change_password
    }

    lateinit var binding: ActivityChangePasswordBinding
    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle(getString(R.string.change_password))
        binding.btnSubmit.setOnClickListener(this)
        setTitle("Home")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_CHANGE_PASSWORD, null, null, true)

        binding.cbShowPassword.setOnCheckedChangeListener(this)
        baseBinding.tvTitle.setOnClickListener(this)
    }


    private fun isValidPassword(password: String): Boolean {

        if (TextUtils.isEmpty(password)) {
            showError("Please enter password")
            return false
        }

        if (password.length < 6) {
            showError("Please enter minimum 6 character")
            return false
        }
        var isUpperCase = false
        password.forEach {
            if (it in 'A'..'Z') {
                isUpperCase = true
            }
        }
        if (!isUpperCase) {
            showError("Please enter at least one upper case letter")
            return false
        }
        var isDigit = false
        password.forEach {
            if (it in '0'..'9') {
                isDigit = true
            }

        }

        if (!isDigit) {
            showError("Please enter at least  one number")
            return false
        }
        return true
    }

    override fun onClick(v: View?) {

        when (v?.id) {
            baseBinding.tvTitle.id -> {
                finish()
            }

            binding.btnSubmit.id -> {
                AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_CLICKED, AnalyticsController.AnalyticScreen.SCREEN_CHANGE_PASSWORD, null,"Change password clicked" , true)
                doLogin()
            }
        }


    }

    private fun doLogin() {
        val newPassword = binding.etNewPassword.text.toString().trim()

        if (!isValidPassword(newPassword)) {
            return
        }

        val oldPassword = binding.etOldPassword.text.toString().trim()
        val confirmPassword = binding.etConfirmPassword.text.toString().trim()
        if (!newPassword.equals(confirmPassword)) {
            showError("Confirm password and new password are not same")
            return
        }

        val request = ChangePasswordRequest()
        request.newPassword = newPassword
        request.confirmPassword = confirmPassword
        request.oldPassword = oldPassword

        val service = UserModuleService<LoginModuleApi, ChangePasswordResponse>(
            LoginModuleApi::class.java,
            this
        )
        showLoading(true)
        service.execute(object : BaseAPICallback<LoginModuleApi, ChangePasswordResponse>() {
            override fun onSuccess(response: ChangePasswordResponse, rawResponse: Response) {
                if (response.success) {
                    showAlertDialog(
                        "Password changed", "Okay",
                        DialogInterface.OnClickListener { _, _ -> finish() }, "", null
                    )
                } else {
                    showAlertDialog(
                        response.errorMsg, "Okay",
                        null, "", null
                    )
                }
            }

            override fun onFailure(e: APIException) {
            }

            override fun onComplete() {
                showLoading(false)
            }

            override fun getAPIAsync(api: LoginModuleApi): Deferred<retrofit2.Response<ChangePasswordResponse>> {
                return api.changePasswordAsync(request)
            }
        })
    }

    override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
        if (isChecked) {
            showPassword(binding.etOldPassword)
            showPassword(binding.etNewPassword)
            showPassword(binding.etConfirmPassword)
        } else {
            hidePassword(binding.etOldPassword)
            hidePassword(binding.etNewPassword)
            hidePassword(binding.etConfirmPassword)

        }

    }

    private fun showPassword(editText: EditText?) {
        editText?.transformationMethod =
            HideReturnsTransformationMethod.getInstance()
    }

    private fun hidePassword(editText: EditText?) {
        editText?.transformationMethod =
            PasswordTransformationMethod.getInstance()
    }


}