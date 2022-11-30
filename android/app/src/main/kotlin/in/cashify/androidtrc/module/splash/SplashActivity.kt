package `in`.cashify.androidtrc.module.splash

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivitySplashBinding
import `in`.cashify.androidtrc.module.login.LoginActivity
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.util.AdvertiseIdGenerator
import `in`.reglobe.cashify.module.AdvertiseIdGenerateListener
import `in`.reglobe.cashify.util.DeviceInfoManager
import android.animation.Animator
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.text.TextUtils
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import com.google.firebase.analytics.FirebaseAnalytics

class SplashActivity : BaseActivity(), Animator.AnimatorListener {

    override fun onAnimationRepeat(animation: Animator?) {

    }

    override fun onAnimationEnd(animation: Animator?) {
        load()
    }

    override fun onAnimationCancel(animation: Animator?) {
    }

    override fun onAnimationStart(animation: Animator?) {
    }

    lateinit var binding: ActivitySplashBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_splash
    }

    override fun hasActionBar(): Boolean {
        return false
    }

    private fun load() {

        Handler().postDelayed({
            if (AppInfoProvider.getInstance().isUserLogin) {
                startActivity(Intent(this, HomeActivity::class.java))
            } else {
                startActivity(Intent(this, LoginActivity::class.java))
            }
            finish()
        }, 0)
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setAdvertisementId()
        binding.splashAnimation.enableMergePathsForKitKatAndAbove(false)
        binding.splashAnimation.setAnimation(R.raw.cashify_splash)
        binding.splashAnimation.addAnimatorListener(this)
        binding.splashAnimation.playAnimation()

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_SPLASH, null, null, true)
//        load()
//        binding.lavGear.enableMergePathsForKitKatAndAbove(true)
//        binding.lavGear.setAnimation(R.raw.gear_splash)
//        binding.lavGear.addAnimatorListener(this)
//        binding.lavGear.playAnimation()
//
//        binding.lavWrench.enableMergePathsForKitKatAndAbove(true)
//        binding.lavWrench.setAnimation(R.raw.splash_wrench)
//        binding.lavWrench.addAnimatorListener(this)
//        binding.lavWrench.playAnimation()

    }

    private fun setAdvertisementId() {
        if (!TextUtils.isEmpty(DeviceInfoManager.getUniqueDeviceId(this))) {
            return
        }
        AdvertiseIdGenerator(this, object : AdvertiseIdGenerateListener {
            override fun onDeviceIdGenerate(advertId: String) {
                try {
                    DeviceInfoManager.setUniqueDeviceId(this@SplashActivity, advertId)
                } catch (ignored: Exception) {

                }
            }
        }).execute()
    }

}