package `in`.cashify.androidtrc.util

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import javax.inject.Inject

class AppUtils @Inject constructor(var preferenceUtils: PreferenceUtils) {

    private var gsonBuilder: Gson = GsonBuilder().create()

}