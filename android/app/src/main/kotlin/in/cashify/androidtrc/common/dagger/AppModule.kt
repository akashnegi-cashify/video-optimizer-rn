package `in`.cashify.androidtrc.common.dagger

import `in`.cashify.androidtrc.util.*
import `in`.cashify.androidtrc.util.ViewModelModule
import android.app.Application
import android.content.Context
import com.google.gson.FieldNamingPolicy
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module(includes = [ViewModelModule::class])
class AppModule {

    @Provides
    internal fun provideApplicationContext(application: Application): Context {
        return application.applicationContext
    }
    @Provides
    fun provideActivityHelper() = ActivityHelper()

    @Provides
    fun providePreferenceUtils(context: Context) = PreferenceUtils(context = context)

    @Provides
    fun provideAppUtils(preference: PreferenceUtils) = AppUtils(preference)

    @Provides
    internal fun provideGson(): Gson {
        val gsonBuilder = GsonBuilder()
        gsonBuilder.setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
        return gsonBuilder.create()
    }

    @Provides
    internal fun provideResource(context: Context): ResourceProvider {
        return ResourceProvider(context)
    }
}
