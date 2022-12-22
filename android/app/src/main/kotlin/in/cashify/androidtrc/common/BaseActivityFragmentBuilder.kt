package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.common.fragment.NoInternetFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class BaseActivityFragmentBuilder {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideNoInternetFragment(): NoInternetFragment


}
