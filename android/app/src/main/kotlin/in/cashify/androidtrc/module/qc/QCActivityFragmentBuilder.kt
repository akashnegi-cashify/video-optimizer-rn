package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned.IMAssignedDeviceDetailsFragment
import `in`.cashify.androidtrc.module.qc.ui.QCHomeFragment
import `in`.cashify.androidtrc.module.qc.ui.QCPendingFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class QCActivityFragmentBuilder: BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideQCHomeFragment(): QCHomeFragment



    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideQCPendingFragment(): QCPendingFragment

}