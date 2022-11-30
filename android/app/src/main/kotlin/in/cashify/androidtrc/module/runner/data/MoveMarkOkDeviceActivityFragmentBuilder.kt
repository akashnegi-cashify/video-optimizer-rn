package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class MoveMarkOkDeviceActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideScannerFragment(): BarcodeScannerFragment
}
