package `in`.cashify.androidtrc.module.engineer.view_report.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 21/12/20.
 */
class EngineerDeviceReportReponse : BaseResponse() {

    @SerializedName("r_id")
    var requestId:String? = null


    @SerializedName("dt")
    var data:Data? = null




class Data:BaseResponse(){


    @SerializedName("tad")
    var totalAssignDevice:Int? = 0

    @SerializedName("mod")
    var markedOkDevice:Int? = 0


    @SerializedName("mopd")
    var markedOkPassDevice:Int? = 0


    @SerializedName("mofd")
    var markedOkFailDevice:Int? = 0


    @SerializedName("eff")
    var efficiency:Double? = 0.0


    @SerializedName("avgrt")
    var avgRepairTime:Long? = 0



}
}