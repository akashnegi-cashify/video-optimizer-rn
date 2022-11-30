package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngPartInfoFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreInHomeFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreOutHomeFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.StoreOutScanFragment
import `in`.cashify.androidtrc.module.storageManager.ui.fragment.VirtualStoreFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
@Module
abstract class StoreInFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideEngPartListFragment(): StoreInHomeFragment
}