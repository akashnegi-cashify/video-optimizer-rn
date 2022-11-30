package `in`.cashify.androidtrc.module.rubbing_engineer.ui

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.elss.ui.fragment.DetailSelectionFragment
import `in`.cashify.androidtrc.module.elss.ui.fragment.ScanElssBarcodeFragment
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment.ReceivedRubbingDeviceFragment
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment.ScanRubbingBarcodeFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.DeviceAllocatedFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class RubbingActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideReceivedRubbingDeviceFragment(): ReceivedRubbingDeviceFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideScanRubbingBarcodeFragment(): ScanRubbingBarcodeFragment
}
