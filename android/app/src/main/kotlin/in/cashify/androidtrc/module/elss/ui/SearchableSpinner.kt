package `in`.cashify.androidtrc.module.elss.ui

import `in`.cashify.androidtrc.R
import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.DialogInterface
import android.text.TextUtils
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View
import android.view.View.OnTouchListener
import android.widget.ArrayAdapter
import android.widget.SpinnerAdapter
import androidx.appcompat.widget.AppCompatSpinner
import java.util.*
import kotlin.collections.ArrayList

class SearchableSpinner : AppCompatSpinner, OnTouchListener,
    SearchableListDialog.SearchableItem<Any> {
    private var _context: Context
    private var _items: ArrayList<Any>? = null
    private var _searchableListDialog: SearchableListDialog? = null
    private var _isDirty = false
    fun set_isDirty(_isDirty: Boolean) {
        this._isDirty = _isDirty
    }

    private var _arrayAdapter: ArrayAdapter<*>? = null
    private var _strHintText: String? = null
    private var _isFromInit = false

    constructor(context: Context) : super(context) {
        _context = context
        init()
    }

    constructor(
        context: Context,
        attrs: AttributeSet?
    ) : super(context, attrs) {
        _context = context
        val a = context.obtainStyledAttributes(attrs, R.styleable.SearchableSpinner)
        val N = a.indexCount
        for (i in 0 until N) {
            val attr = a.getIndex(i)
            if (attr == R.styleable.SearchableSpinner_hintText) {
                _strHintText = a.getString(attr)
            }
        }
        a.recycle()
        init()
    }

    constructor(
        context: Context,
        attrs: AttributeSet?,
        defStyleAttr: Int
    ) : super(context, attrs, defStyleAttr) {
        _context = context
        init()
    }

    private fun init() {
        _items = ArrayList()
        _searchableListDialog = SearchableListDialog.newInstance(_items)
        _searchableListDialog?.setOnSearchableItemClickListener(this)
        setOnTouchListener(this)
        _arrayAdapter = adapter as ArrayAdapter<*>
        if (!TextUtils.isEmpty(_strHintText)) {
            val arrayAdapter: ArrayAdapter<*> = ArrayAdapter<Any?>(
                _context,
                android.R.layout.simple_list_item_1,
                arrayOf(_strHintText)
            )
            _isFromInit = true
            setAdapter(arrayAdapter)
        }
    }

    override fun onTouch(v: View, event: MotionEvent): Boolean {
        if (_searchableListDialog!!.isAdded) {
            return true
        }
        if (event.action == MotionEvent.ACTION_UP) {
            if (null != _arrayAdapter) {

                // Refresh content #6
                // Change Start
                // Description: The items were only set initially, not reloading the data in the
                // spinner every time it is loaded with items in the adapter.
                _items!!.clear()
                for (i in 0 until _arrayAdapter!!.count) {
                    _items!!.add(_arrayAdapter!!.getItem(i).toString())
                }
                _searchableListDialog!!.show(scanForActivity(_context)!!.fragmentManager, "TAG")
            }
        }
        return true
    }

    override fun setAdapter(adapter: SpinnerAdapter) {
        if (!_isFromInit) {
            _arrayAdapter = adapter as ArrayAdapter<*>
            if (!TextUtils.isEmpty(_strHintText) && !_isDirty) {
                val arrayAdapter: ArrayAdapter<*> = ArrayAdapter<Any?>(
                    _context,
                    android.R.layout.simple_list_item_1,
                    arrayOf(_strHintText)
                )
                super.setAdapter(arrayAdapter)
            } else {
                super.setAdapter(adapter)
            }
        } else {
            _isFromInit = false
            super.setAdapter(adapter)
        }
    }

    override fun onSearchableItemClicked(item: Any, position: Int) {
        setSelection(_items!!.indexOf(item))
        if (!_isDirty) {
            _isDirty = true
            adapter = _arrayAdapter!!
            setSelection(_items!!.indexOf(item))
        }
    }

    fun setTitle(strTitle: String?) {
        _searchableListDialog!!.setTitle(strTitle)
    }

    fun setPositiveButton(strPositiveButtonText: String?) {
        _searchableListDialog!!.setPositiveButton(strPositiveButtonText)
    }

    fun setPositiveButton(
        strPositiveButtonText: String?,
        onClickListener: DialogInterface.OnClickListener?
    ) {
        _searchableListDialog!!.setPositiveButton(strPositiveButtonText, onClickListener)
    }

    fun setOnSearchTextChangedListener(onSearchTextChanged: SearchableListDialog.OnSearchTextChanged?) {
        _searchableListDialog!!.setOnSearchTextChangedListener(onSearchTextChanged)
    }

    private fun scanForActivity(cont: Context?): Activity? {
        if (cont == null) return null else if (cont is Activity) return cont else if (cont is ContextWrapper) return scanForActivity(
            cont.baseContext
        )
        return null
    }

    override fun getSelectedItemPosition(): Int {
        return if (!TextUtils.isEmpty(_strHintText) && !_isDirty) {
            NO_ITEM_SELECTED
        } else {
            super.getSelectedItemPosition()
        }
    }

    override fun getSelectedItem(): Any? {
        return if (!TextUtils.isEmpty(_strHintText) && !_isDirty) {
            null
        } else {
            super.getSelectedItem()
        }
    }

    companion object {
        const val NO_ITEM_SELECTED = -1
    }
}