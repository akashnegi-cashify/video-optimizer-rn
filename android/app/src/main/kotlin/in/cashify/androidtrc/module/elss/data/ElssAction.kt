package `in`.cashify.androidtrc.module.elss.data


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
//enum class ElssAction(val actionString: String) {
//    REPAIRABLE("Repairable"),
//    NOT_REPAIRABLE("Not Repairable"),
//    NOT_REQUIRED("Not Required")
//}

enum class ElssAction(val actionString: String) {
    REPAIRABLE("Required"),
    NOT_REPAIRABLE("Not Repairable"),
    NOT_REQUIRED("Not Required"),
    REPAIRABLE_SERVER("Repairable")


    // REPAIRABLE and REPAIRABLE_SERVER is same , but at android we use "Required" string to show it to user while we send "Repairable" to server
}