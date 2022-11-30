package `in`.cashify.androidtrc.util.widget

import android.content.Context
import android.util.AttributeSet
import androidx.appcompat.widget.AppCompatSpinner

/**
 * Created by Rishika on 30/12/20.
 */
class DateSpinner : AppCompatSpinner {
    constructor(context: Context) : super(context) {}
    constructor(context: Context, attrs: AttributeSet?) : super(
        context,
        attrs
    ) {
    }

    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyle: Int
    ) : super(context, attrs, defStyle) {
    }

    override fun setSelection(position: Int, animate: Boolean) {
        val sameSelected = position == selectedItemPosition
        super.setSelection(position, animate)
        if (sameSelected) {
            // Spinner does not call the OnItemSelectedListener if the same item is selected, so do it manually now
            onItemSelectedListener!!.onItemSelected(
                this,
                selectedView,
                position,
                selectedItemId
            )
        }
    }

    override fun setSelection(position: Int) {
        val sameSelected = position == selectedItemPosition
        super.setSelection(position)
        if (sameSelected) {
            // Spinner does not call the OnItemSelectedListener if the same item is selected, so do it manually now
            onItemSelectedListener!!.onItemSelected(
                this,
                selectedView,
                position,
                selectedItemId
            )
        }
    }
}