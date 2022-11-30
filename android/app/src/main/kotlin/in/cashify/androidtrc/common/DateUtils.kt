package `in`.cashify.androidtrc.common



import java.text.DateFormat
import java.text.SimpleDateFormat
import java.time.ZoneOffset
import java.time.format.DateTimeFormatter
import java.util.*
import java.util.concurrent.TimeUnit


/**
 * Created by Rishika on 22/12/20.
 */
object DateUtils {

var dateTimeFormat = "dd-MMM-yyyy  hh:mm a"



    fun getTime(millis: Long?):String {
//        try {
            if (millis == null) {
                return ""
            }
        val hours = TimeUnit.MILLISECONDS.toHours(millis).toInt() % 24
        val minutes = TimeUnit.MILLISECONDS.toMinutes(millis).toInt() % 60
        val seconds = TimeUnit.MILLISECONDS.toSeconds(millis).toInt() % 60
        return when {
            hours > 0 -> String.format(
                "%d Hours %02d Minutes %02d Seconds",
                hours,
                minutes,
                seconds
            )
            minutes > 0 -> String.format("%02d Minutes %02d Seconds", minutes, seconds)
            seconds > 0 -> String.format("00:%02d Seconds", seconds)
            else -> {
                "0 Hours 0 Minutes 0 Seconds"
            }
        }
    }






    fun getTodayDate():String{
        val formatter = SimpleDateFormat("dd/MM/yyyy")
        val date = Date()
        return formatter.format(date)

    }



    fun getYesterdayDate():String{
      val cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);


        val dateFormat: DateFormat = SimpleDateFormat("dd/MM/yyyy")
        return dateFormat.format(cal.time)

    }



    fun getDateByDay(days: Int):String{
        val cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -days);


        val dateFormat: DateFormat = SimpleDateFormat("dd/MM/yyyy")
        return dateFormat.format(cal.time)
    }



    fun firstDayMonth():String{
        val c = Calendar.getInstance() // this takes current date

        c[Calendar.DAY_OF_MONTH] = 1
        val dateFormat: DateFormat = SimpleDateFormat("dd/MM/yyyy")
        return dateFormat.format(c.time)

    }



    fun dateOfFirstDayOfLastMonth():String{
        val c = Calendar.getInstance() // this takes current date
        c.add(Calendar.MONTH, -1);
        c[Calendar.DAY_OF_MONTH] = 1
        val dateFormat: DateFormat = SimpleDateFormat("dd/MM/yyyy")
        return dateFormat.format(c.time)
    }


    fun dateOfLastDayOfLastMonth():String{
        val c = Calendar.getInstance() // this takes current date
        c.add(Calendar.MONTH, -1);
        c[Calendar.DAY_OF_MONTH] = c.getActualMaximum(Calendar.DATE)
        val dateFormat: DateFormat = SimpleDateFormat("dd/MM/yyyy")
        return dateFormat.format(c.time)
    }





    fun getDate(date: Long, dateFormat: String):String{
        try {



            val dateFormat: DateFormat = SimpleDateFormat(
                dateFormat
            )
            return dateFormat.format(date)
        }

        catch (e: Exception){
            return ""
        }

    }

}