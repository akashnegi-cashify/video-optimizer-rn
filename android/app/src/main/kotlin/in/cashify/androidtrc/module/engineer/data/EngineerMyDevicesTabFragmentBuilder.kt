package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngDeviceListFragment
import `in`.cashify.androidtrc.module.engineer.ui.fragment.WipDeviceFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector


@Module
abstract class EngineerMyDevicesTabFragmentBuilder : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class ])
    internal abstract fun provideEngDeviceListFragment(): EngDeviceListFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class ])
    internal abstract fun provideWipDeviceFragment(): WipDeviceFragment
}