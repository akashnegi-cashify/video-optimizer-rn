package `in`.cashify.androidtrc.module.rubbing_engineer.adapter

import `in`.cashify.androidtrc.R
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import androidx.recyclerview.widget.RecyclerView

abstract class PagingAdapter <T> : RecyclerView.Adapter<RecyclerView.ViewHolder>() {
    private val mData: ArrayList<T> = ArrayList()
    private var mHasMore = true
    val dataSetObserver: DataSetObserver<T> = object : DataSetObserver<T> {
        override fun onDataSetChanged(data: List<T>?, hasMore: Boolean) {
            mHasMore = hasMore
            if (data != null) {
                mData.addAll(data)
            }
            notifyDataSetChanged()
        }
    }

    override fun getItemCount(): Int {
        val size = dataSize
        return if (mHasMore) {
            size + 1
        } else size
    }

    val data: List<T>
        get() = mData


    fun getItem(position: Int): T {
        return mData[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return if (viewType == REFRESH_VIEW) {
            onCreateFooterViewHolder(parent)
        } else onCreateBasicItemViewHolder(parent, viewType)
    }

    abstract fun onCreateBasicItemViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder
    abstract fun onBindBasicItemView(genericHolder: RecyclerView.ViewHolder, position: Int)
    override fun onBindViewHolder(genericHolder: RecyclerView.ViewHolder, position: Int) {
        if (getItemViewType(position) == REFRESH_VIEW) {
            getNextPage(dataSetObserver)
            onBindFooterView(genericHolder)
        } else {
            onBindBasicItemView(genericHolder, position)
        }
    }

    override fun getItemViewType(position: Int): Int {
        return if (isLastCell(position)) REFRESH_VIEW else super.getItemViewType(position)
    }

    fun isLastCell(position: Int): Boolean {
        return position == dataSize
    }

    private val dataSize: Int
        private get() = mData.size

    fun hasMoreData(): Boolean {
        return mHasMore
    }

    fun clear() {
        mData.clear()
        notifyDataSetChanged()
    }

    fun removeItem(position: Int) {
        mData.removeAt(position)
        notifyDataSetChanged()
    }

    class ProgressViewHolder(v: View) : RecyclerView.ViewHolder(v) {
        @JvmField
        var progressBar: ProgressBar

        init {
            progressBar = v.findViewById(R.id.progressBar)
        }
    }

    fun onCreateFooterViewHolder(parent: ViewGroup): RecyclerView.ViewHolder {
        val v: View = LayoutInflater.from(parent.context)
            .inflate(R.layout.progress_bar, parent, false)
        return ProgressViewHolder(v)
    }

    open fun onBindFooterView(genericHolder: RecyclerView.ViewHolder) {
        (genericHolder as ProgressViewHolder).progressBar.isIndeterminate = true

    }

    protected abstract fun getNextPage(dataSetObserver: DataSetObserver<T>)
    fun setHasMoreTrue(hasMore: Boolean) {
        mHasMore = hasMore
    }

    interface DataSetObserver<T> {
        fun onDataSetChanged(data: List<T>?, hasMore: Boolean)
    }

    companion object {
        private const val REFRESH_VIEW = -1
    }
}