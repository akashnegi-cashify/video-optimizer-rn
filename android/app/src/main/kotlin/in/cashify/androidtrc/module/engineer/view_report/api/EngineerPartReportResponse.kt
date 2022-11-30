package `in`.cashify.androidtrc.module.engineer.view_report.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 21/12/20.
 */
class EngineerPartReportResponse : BaseResponse() {


    @SerializedName("r_id")
    var requestId:String? = null


    @SerializedName("dt")
    var data:Data? = null


    class Data:BaseResponse(){
        @SerializedName("avgpc")
        var avgPartCost:Double? = 0.0
        @SerializedName("avgpcon")
        var avgPartConsumption:Double? = 0.0
        @SerializedName("pr")
        var partsAssign:Int? = 0
        @SerializedName("pc")
        var partsConsume:Int? = 0
        @SerializedName("pret")
        var partsReturn:Int? = 0
        @SerializedName("preq")
        var partsRequested:Int? = 0

    }




    }
