package `in`.cashify.androidtrc.util

import `in`.cashify.androidtrc.R
import android.content.Context
import java.text.NumberFormat
import java.util.*

object MathUtil {

    val locale: Locale
        get() = Locale("en", "IN")

    fun formatAmount(amount: Double?, context: Context): String {
        return formatAmount(amount, context, 0)
    }

    private fun formatAmount(amount: Double?, context: Context, fractionDigitCount: Int): String {
        var amount = amount
        amount = if (amount!! < 0) 0.0 else amount
        val formatter = NumberFormat.getNumberInstance(Locale.US)
        formatter.maximumFractionDigits = fractionDigitCount
        val formattedAmount = formatter.format(amount)
        return String.format(context.getString(R.string.text_price), formattedAmount)
    }

    //    public static float getAngleBetweenTwoLinesInDegree(){
}
