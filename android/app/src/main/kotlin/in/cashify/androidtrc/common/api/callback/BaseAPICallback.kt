package `in`.cashify.androidtrc.common.api.callback

import `in`.reglobe.api.kotlin.callback.APICallback
import `in`.reglobe.api.kotlin.response.APIResponse

abstract class BaseAPICallback<U, T : APIResponse> : APICallback<U, T>() {
}