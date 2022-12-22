package `in`.cashify.androidtrc.util

import `in`.reglobe.api.kotlin.exception.APIException
import androidx.annotation.Nullable

class Validation {

    object companion {


        @Nullable
        fun isValidMobileNumber(number: String?): Boolean {
            if (isNullOrEmpty(number)) {
                throw APIException(APIException.Kind.NULL,"Mobile number can not be empty")
            } else {
                return number!!.matches("^[6789][0-9]{9}$".toRegex())
            }
        }

        fun isNullOrEmpty(str: String?): Boolean {
            return str == null || str.trim().isEmpty()
        }

        fun isValidEmail(target: String): Boolean {
            return android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches()
        }
    }
}
