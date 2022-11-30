package `in`.cashify.androidtrc.util.widget.pie_chart

import `in`.cashify.androidtrc.R
import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.RectF
import android.util.AttributeSet
import android.view.View
import androidx.core.content.ContextCompat

/**
 * Created by Rishika on 04/12/20.
 */
class PieChartView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0) : View(context, attrs, defStyleAttr) {

    private var slicePaint: Paint = Paint()
    private var centerPaint: Paint = Paint()
    private var sliceColors: IntArray = intArrayOf(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
    private var rectF: RectF? = null
    private var dataPoints: FloatArray = floatArrayOf()

    init {
        slicePaint.isAntiAlias = true
        slicePaint.isDither = true
        slicePaint.style = Paint.Style.FILL

        centerPaint.color = Color.WHITE
        centerPaint.style = Paint.Style.FILL
    }

    private fun scale(): FloatArray? {
        val scaledValues = FloatArray(dataPoints.size)
        var sum = 0f
        dataPoints?.forEach {
            sum = sum+ it
        }

        if(sum <= 0f){
            return null
        }

        for (i in dataPoints.indices) {
            scaledValues.fill((dataPoints[i] / getTotal()) * 360, i, dataPoints.size)
        }
        return scaledValues
    }

    @SuppressLint("DrawAllocation")
    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)

//        canvas?.drawColor(Color.RED)

        val startTop = 0F
        val startLeft = 0F
        val endBottom = width.toFloat()
        val endRight = endBottom

        rectF = RectF(startLeft, startTop, endRight, endBottom)

        val scaledValues = scale()
        var sliceStartPoint = 0F
//

   if(scaledValues == null){
               val centerX = (measuredWidth / 2).toFloat()
        val centerY = (measuredHeight / 2).toFloat()
        val radius = Math.min(centerX, centerY)
        centerPaint.color = ContextCompat.getColor(context, R.color.lightGrey)
        canvas!!.drawCircle(centerX, centerY, radius - 70, centerPaint)
       return
   }

        for (i in scaledValues!!.indices) {
            slicePaint.color = ContextCompat.getColor(context, sliceColors[i])
            canvas!!.drawArc(rectF!!, sliceStartPoint, scaledValues[i], true, slicePaint)
            sliceStartPoint += scaledValues[i]
        }


//        val centerX = (measuredWidth / 2).toFloat()
//        val centerY = (measuredHeight / 2).toFloat()
//        val radius = Math.min(centerX, centerY)
//        centerPaint.color = ContextCompat.getColor(context, R.color.teal)
//        canvas!!.drawCircle(centerX, centerY, radius - 70, centerPaint)








//        canvas!!.drawCircle(centerX, centerY, radius - 70, centerPaint)

    }

    fun getTotal(): Float = dataPoints.sum()

    fun setDataPoints(data: FloatArray) {
        dataPoints = data
        invalidateAndRequestLayout()
    }

    fun setCenterColor(colorId: Int) {
        centerPaint.color = ContextCompat.getColor(context, colorId)
        invalidateAndRequestLayout()
    }

    fun setSliceColor(colors: IntArray) {
        sliceColors = colors
        invalidateAndRequestLayout()
    }

    private fun invalidateAndRequestLayout() {
        invalidate()
        requestLayout()
    }
}