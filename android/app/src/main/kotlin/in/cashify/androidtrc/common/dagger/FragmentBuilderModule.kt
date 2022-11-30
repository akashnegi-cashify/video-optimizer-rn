package `in`.cashify.androidtrc.common.dagger

import `in`.cashify.androidtrc.common.BaseFragment
import androidx.databinding.ViewDataBinding
import dagger.Binds
import dagger.Module

@Module
abstract class FragmentBuilderModule {
    @Binds
    internal abstract fun bindBaseActivity(fragment: BaseFragment): BaseFragment
}
