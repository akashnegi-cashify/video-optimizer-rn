package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.module.engineer.ui.fragment.SelfAssignPartFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.VirtualStoreFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

/**
 * Created by Rishika on 20/10/20.
 */
@Module
abstract class SelfAssignFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideSelfAssignFragment(): SelfAssignPartFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideBarcodeScanner(): BarcodeScannerFragment
}