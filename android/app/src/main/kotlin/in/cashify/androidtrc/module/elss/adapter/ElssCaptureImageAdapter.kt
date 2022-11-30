package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import android.graphics.drawable.Drawable
import android.text.TextUtils
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CompoundButton
import android.widget.ImageView
import android.widget.ProgressBar
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.DataSource
import com.bumptech.glide.load.engine.GlideException
import com.bumptech.glide.request.RequestListener
import com.bumptech.glide.request.RequestOptions
import com.bumptech.glide.request.target.Target

/**
 * Created by Rishika on 24/11/20.
 */
class ElssCaptureImageAdapter(
    var imagePathList: ArrayList<String>,
    var onImageClickListener: OnImageClickListener
) : RecyclerView.Adapter<ElssCaptureImageAdapter.ElssCaptureImageHolder>() {


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ElssCaptureImageHolder {
        return ElssCaptureImageHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_capture_image,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        Log.d("sizeeeeee", imagePathList.size.toString())
        return imagePathList.size
    }

    override fun onBindViewHolder(holder: ElssCaptureImageHolder, position: Int) {
        holder.progressBar?.visibility = View.GONE
        imagePathList.get(position).let {
            if (TextUtils.isEmpty(it)) {
                if (holder.img?.context != null) {
                    holder.img?.setImageResource(R.drawable.ic_add_grey)

                }


            } else {
                if (holder.img?.context != null) {

                    holder.progressBar?.visibility = View.VISIBLE
                    Glide.with(holder.img?.context!!)
                        .load(imagePathList.get(position))
                        .listener(object : RequestListener <Drawable> {


                            override fun onLoadFailed(
                                e: GlideException?,
                                model: Any?,
                                target: Target<Drawable>?,
                                isFirstResource: Boolean
                            ): Boolean {
                                holder.progressBar?.visibility = View.GONE
                                return false
                            }

                            override fun onResourceReady(
                                resource: Drawable?,
                                model: Any?,
                                target: Target<Drawable>?,
                                dataSource: DataSource?,
                                isFirstResource: Boolean
                            ): Boolean {
                                holder.progressBar?.visibility = View.GONE
                                return false
                            }
                        })

                        .into(holder.img!!)

//                    Glide.with(holder.img?.context!!).load(imagePathList.get(position))
//                        .into(holder.img!!)
                }
            }
        }


    }

    inner class ElssCaptureImageHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        CompoundButton.OnCheckedChangeListener, View.OnClickListener {


        var img: ImageView? = null
        var progressBar:ProgressBar? = null

        init {

            img = itemView.findViewById(R.id.img)
            progressBar = itemView.findViewById(R.id.progress_bar)
            itemView.setOnClickListener {
                onImageClickListener.onImageClick(adapterPosition)


            }
        }

        override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {

        }

        override fun onClick(v: View?) {

        }
    }

    interface OnImageClickListener {
        fun onImageClick(pos: Int)
    }
}