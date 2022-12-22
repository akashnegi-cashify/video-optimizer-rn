package `in`.cashify.androidtrc.common

import android.util.Base64
import org.json.JSONObject

object JWTParser {
    private const val HEADER = 0
    private const val PAYLOAD = 1
    private const val SIGNATURE = 2
    private const val JWT_PARTS = 3

    /**
     * Returns header for a JWT as a JSON object.
     *
     * @param jwt REQUIRED: valid JSON Web Token as String.
     * @return header as a JSONObject.
     */
    @Throws(Exception::class)
    fun getHeader(jwt: String): JSONObject {
        return try {
            validateJWT(jwt)
            val sectionDecoded = Base64.decode(
                jwt.split("\\.".toRegex()).toTypedArray()[HEADER],
                Base64.URL_SAFE
            )
            val jwtSection = String(sectionDecoded, charset("UTF-8"))
            JSONObject(jwtSection)
        } catch (e: Exception) {
            throw Exception(e.message)
        }
    }

    /**
     * Returns payload of a JWT as a JSON object.
     *
     * @param jwt REQUIRED: valid JSON Web Token as String.
     * @return payload as a JSONObject.
     */
    @Throws(Exception::class)
    fun getPayload(jwt: String): JSONObject {
        return try {
            validateJWT(jwt)
            val payload =
                jwt.split("\\.".toRegex()).toTypedArray()[PAYLOAD]
            val sectionDecoded =
                Base64.decode(payload, Base64.URL_SAFE)
            val jwtSection = String(sectionDecoded, charset("UTF-8"))
            JSONObject(jwtSection)
        } catch (e: Exception) {
            throw Exception(e.message)
        }
    }

    /**
     * Returns signature of a JWT as a String.
     *
     * @param jwt REQUIRED: valid JSON Web Token as String.
     * @return signature as a String.
     */
    @Throws(Exception::class)
    fun getSignature(jwt: String): String {
        return try {
            validateJWT(jwt)
            val sectionDecoded = Base64.decode(
                jwt.split("\\.".toRegex()).toTypedArray()[SIGNATURE],
                Base64.URL_SAFE
            )
            String(sectionDecoded, charset("UTF-8"))
        } catch (e: Exception) {
            throw Exception("error in parsing JSON")
        }
    }

    /**
     * Returns a claim, from the `JWT`s' payload, as a String.
     *
     * @param jwt   REQUIRED: valid JSON Web Token as String.
     * @param claim REQUIRED: claim name as String.
     * @return claim from the JWT as a String.
     */
    @Throws(Exception::class)
    fun getClaim(jwt: String, claim: String?): String? {
        try {
            val payload = getPayload(jwt)
            val claimValue = payload[claim]
            if (claimValue != null) {
                return claimValue.toString()
            }
        } catch (e: Exception) {
            throw Exception("invalid token")
        }
        return null
    }

    /**
     * Checks if `JWT` is a valid JSON Web Token.
     *
     * @param jwt REQUIRED: The JWT as a [String].
     */
    @Throws(Exception::class)
    fun validateJWT(jwt: String) {
        // Check if the the JWT has the three parts
        val jwtParts = jwt.split("\\.".toRegex()).toTypedArray()
        if (jwtParts.size != JWT_PARTS) {
            throw Exception("not a JSON Web Token")
        }
    }
}