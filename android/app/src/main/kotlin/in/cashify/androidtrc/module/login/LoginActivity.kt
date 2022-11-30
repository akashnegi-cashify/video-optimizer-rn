package `in`.cashify.androidtrc.module.login

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityLoginBinding
import `in`.cashify.androidtrc.module.login.api.UserDetailResponse
import `in`.cashify.androidtrc.module.login.data.LoginProcessListener
import `in`.cashify.androidtrc.module.runner.HomeActivity
import android.content.Intent
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil


/**
 * Created by Avaneesh Maurya on 19,July,2019
 */
class LoginActivity : BaseActivity(), LoginProcessListener {
    override fun performVerification() {
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_CLICKED, AnalyticsController.AnalyticScreen.SCREEN_LOGIN, null,"Login clicked" , true)
        val fragment = LoginOtpVerificationFragment.newInstance()
        mActivityHelper.replaceFragment(this, fragment, binding.container.id, true)
    }

    override fun onCompleteLogin(credentials: UserDetailResponse) {
        AppInfoProvider.getInstance().setUserDetailResponse(credentials)
        startActivity(Intent(this, HomeActivity::class.java))
        finish()
    }

    lateinit var binding: ActivityLoginBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_login
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle(getString(R.string.app_name))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_LOGIN, null, null, true)

        val fragment: LoginFragment = LoginFragment.newInstance()
        mActivityHelper.replaceFragment(this, fragment, binding.container.id, true)
    }

    override fun getContainerId(): Int {
        return binding.container.id
    }
}