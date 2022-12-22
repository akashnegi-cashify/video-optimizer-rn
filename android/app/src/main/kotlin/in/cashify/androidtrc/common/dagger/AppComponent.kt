package `in`.cashify.androidtrc.common.dagger

import `in`.cashify.androidtrc.util.PreferenceUtils
import android.app.Application
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjector
import dagger.android.support.AndroidSupportInjectionModule
import dagger.android.support.DaggerApplication


@Component(
    modules = [AndroidSupportInjectionModule::class, AppModule::class, ActivityBuilder::class]
)
interface AppComponent : AndroidInjector<DaggerApplication> {

    fun inject(instance: dagger.android.DaggerApplication)

    fun injectSharedPref(): PreferenceUtils

    @Component.Builder
    interface Builder {
        @BindsInstance
        fun application(application: Application): Builder

        fun build(): AppComponent
    }


}