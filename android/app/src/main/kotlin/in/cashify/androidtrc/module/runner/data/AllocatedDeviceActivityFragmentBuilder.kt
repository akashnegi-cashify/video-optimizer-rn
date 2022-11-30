package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.runner.ui.fragment.DeviceAllocatedFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class AllocatedDeviceActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun providePendingDeviceFragment(): DeviceAllocatedFragment
}
