package `in`.cashify.androidtrc.module.login.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.login.LoginFragment
import `in`.cashify.androidtrc.module.login.LoginOtpVerificationFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class LoginActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideLoginFragment(): LoginFragment

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideLoginOtpVerificationFragment(): LoginOtpVerificationFragment

}
