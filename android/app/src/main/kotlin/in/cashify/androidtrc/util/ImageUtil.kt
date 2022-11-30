package `in`.cashify.androidtrc.util

import `in`.cashify.androidtrc.BuildConfig
import `in`.cashify.androidtrc.TrcApp
import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Intent
import android.graphics.*
import android.net.Uri
import android.os.AsyncTask
import android.os.Environment
import android.provider.MediaStore
import android.text.TextUtils
import android.util.Log
import androidx.core.content.FileProvider
import androidx.exifinterface.media.ExifInterface
import androidx.fragment.app.Fragment
import java.io.*
import java.net.HttpURLConnection
import java.net.URL


object ImageUtil {


    private val HIDDEN_FOLDER_OPERATOR = "."
    private val IMAGE_CASHING_FOLDER = "reglobe"
    val REQUEST_ID_CAPTURE_IMAGE = 100


    private val maxHeight = 1280.0f
    private val maxWidth = 920.0f

    val filename: String
        get() {
            val file = File(TrcApp.appContext?.getCacheDir(), "MyFolder/Images")
            if (!file.exists()) {
                file.mkdirs()
            }
            return file.absolutePath + "/" + System.currentTimeMillis() + ".jpg"


        }


    val fileNameByTime:String
    get() {
        return  "image_" + System.currentTimeMillis()
    }

    fun launchCamera(activity: Activity?, fileName: String?, requestId: Int): String? {
        try {
            if (activity == null) {
                return ""
            }

            if (fileName == null || fileName.isEmpty()) {
                return ""
            }
            val photoFile = createImageFile(activity, fileName)
            val photoFileUri = getFileProviderUri(activity, photoFile!!)
            val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            intent.putExtra(MediaStore.EXTRA_OUTPUT, photoFileUri)
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)

                activity.startActivityForResult(intent, requestId)
                return photoFile.absolutePath


        } catch (e: java.lang.Exception) {
            e.printStackTrace()
        }

        catch (e:ActivityNotFoundException){

        }
        return null
    }







    fun createImageFile(
        activity: Activity?,
        mFileName: String
    ): File? { // Create an image file name
        val storageDir: File = activity!!.filesDir
        return File.createTempFile(mFileName, ".jpg", storageDir)
    }



    private fun getFileProviderUri(activity: Activity?, file: File): Uri? {
        val takePictureIntent =
            Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        if (takePictureIntent.resolveActivity(activity!!.packageManager) != null) { // Create the File where the photo should go

            return FileProvider.getUriForFile(
                activity, BuildConfig.APPLICATION_ID + ".provider",
                file
            )
        }
        return null
    }


    private fun canResolve(activity: Activity?, intent: Intent): Boolean {
        if (activity == null) {
            return false
        }
        val packageManager = activity.packageManager
        return intent.resolveActivity(packageManager) != null
    }

    fun launchCamera(fragment: Fragment?, fileName: String): String? {
        if (fragment == null || TextUtils.isEmpty(fileName)) {
            return null
        }

        val folder =
            File(Environment.getExternalStorageDirectory().toString() + "/" + HIDDEN_FOLDER_OPERATOR + IMAGE_CASHING_FOLDER)
        var exist = true
        if (!folder.exists()) {
            exist = folder.mkdir()
        }

        if (!exist) {
            return null
        }

        val photoFile = File(folder, fileName)
        val photoFileUri = Uri.fromFile(photoFile)

        val intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
        intent.putExtra(MediaStore.EXTRA_OUTPUT, photoFileUri)
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        fragment.startActivityForResult(intent, REQUEST_ID_CAPTURE_IMAGE)

        return photoFileUri.path
    }


    fun calculateInSampleSize(options: BitmapFactory.Options, reqWidth: Int, reqHeight: Int): Int {
        val height = options.outHeight
        val width = options.outWidth
        var inSampleSize = 1
        if (height > reqHeight || width > reqWidth) {
            if (width > height) {
                inSampleSize = Math.round(height.toFloat() / reqHeight.toFloat())
            } else {
                inSampleSize = Math.round(width.toFloat() / reqWidth.toFloat())
            }
        }
        return inSampleSize
    }

    fun getBytesFromBitmap(bitmap: Bitmap): ByteArray {
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.JPEG, 70, stream)
        return stream.toByteArray()
    }


    fun compressImage(imagePath: String): String? {
        try {
            var scaledBitmap: Bitmap? = null
            val options = BitmapFactory.Options()
            options.inJustDecodeBounds = true
            var bmp = BitmapFactory.decodeFile(imagePath, options)

            var actualHeight = options.outHeight
            var actualWidth = options.outWidth

            var imgRatio = actualWidth.toFloat() / actualHeight.toFloat()
            val maxRatio = maxWidth / maxHeight

            if (actualHeight > maxHeight || actualWidth > maxWidth) {
                if (imgRatio < maxRatio) {
                    imgRatio = maxHeight / actualHeight
                    actualWidth = (imgRatio * actualWidth).toInt()
                    actualHeight = maxHeight.toInt()
                } else if (imgRatio > maxRatio) {
                    imgRatio = maxWidth / actualWidth
                    actualHeight = (imgRatio * actualHeight).toInt()
                    actualWidth = maxWidth.toInt()
                } else {
                    actualHeight = maxHeight.toInt()
                    actualWidth = maxWidth.toInt()
                }
            }
            options.inSampleSize = calculateInSampleSize(options, actualWidth, actualHeight)
            options.inJustDecodeBounds = false
            options.inDither = false
            options.inPurgeable = true
            options.inInputShareable = true
            options.inTempStorage = ByteArray(16 * 1024)
            try {
                bmp = BitmapFactory.decodeFile(imagePath, options)
            } catch (exception: OutOfMemoryError) {
                exception.printStackTrace()
            }

            try {
                scaledBitmap = Bitmap.createBitmap(actualWidth, actualHeight, Bitmap.Config.RGB_565)
            } catch (exception: OutOfMemoryError) {
                exception.printStackTrace()
            }

            val ratioX = actualWidth / options.outWidth.toFloat()
            val ratioY = actualHeight / options.outHeight.toFloat()
            val middleX = actualWidth / 2.0f
            val middleY = actualHeight / 2.0f
            val scaleMatrix = Matrix()
            scaleMatrix.setScale(ratioX, ratioY, middleX, middleY)
            val canvas = Canvas(scaledBitmap!!)
            canvas.setMatrix(scaleMatrix)
            canvas.drawBitmap(
                bmp,
                middleX - bmp.width / 2,
                middleY - bmp.height / 2,
                Paint(Paint.FILTER_BITMAP_FLAG)
            )
            bmp.recycle()
            val exif: ExifInterface
            try {
                exif = ExifInterface(imagePath)
                val orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, 0)
                val matrix = Matrix()
                if (orientation == 6) {
                    matrix.postRotate(90f)
                } else if (orientation == 3) {
                    matrix.postRotate(180f)
                } else if (orientation == 8) {
                    matrix.postRotate(270f)
                }
                scaledBitmap =
                    Bitmap.createBitmap(
                        scaledBitmap,
                        0,
                        0,
                        scaledBitmap.width,
                        scaledBitmap.height,
                        matrix,
                        true
                    )
            } catch (e: IOException) {
                e.printStackTrace()
            }

            var out: FileOutputStream? = null
            val filepath = filename

            out = FileOutputStream(filepath)
            scaledBitmap!!.compress(Bitmap.CompressFormat.JPEG, 95, out)
            return filepath
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return null
    }


    fun getBitmap(path: String): Bitmap? {
        var bitmap: Bitmap? = null
        val compressedProfilePicPath = compressImage(path)
        if (compressedProfilePicPath != null) {
            bitmap = BitmapFactory.decodeFile(compressedProfilePicPath)
        }

        return bitmap
    }

    fun downloadImageInBackground(imageUrl: String?, listener: DownloadImageListener?) {
        if (imageUrl == null || imageUrl.isEmpty()) {
            Log.d("imageUtil", "Image url must not be null")
            return
        }

        object : AsyncTask<String, Void, Bitmap?>() {
            var bitmap: Bitmap? = null

            override fun onPreExecute() {
                listener?.onStartDownload()
                super.onPreExecute()
            }

            override fun doInBackground(vararg params: String): Bitmap? {
                val imageUrl = params[0]
                try {
                    val url = URL(imageUrl)
                    val connection = url
                        .openConnection() as HttpURLConnection
                    connection.doInput = true
                    connection.connect()
                    val input = connection.inputStream
                    bitmap = BitmapFactory.decodeStream(input)
                } catch (e: Exception) {
                    e.printStackTrace()
                }

                return bitmap
            }

            override fun onPostExecute(bitmap: Bitmap?) {
                if (listener != null) {
                    if (bitmap != null) {
                        listener.onCompleteDownload(bitmap)
                    } else {
                        listener.onFailDownload()
                    }
                    listener.onStopDownload()
                }
                super.onPostExecute(bitmap)
            }
        }.execute(imageUrl)
    }

    fun toGrayScale(bitmap: Bitmap): Bitmap {
        val width: Int
        val height: Int
        height = bitmap.height
        width = bitmap.width

        val bmpGrayScale = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val c = Canvas(bmpGrayScale)
        val paint = Paint()
        val cm = ColorMatrix()
        cm.setSaturation(0f)
        val f = ColorMatrixColorFilter(cm)
        paint.colorFilter = f
        c.drawBitmap(bitmap, 0f, 0f, paint)
        return bmpGrayScale
    }



    fun fileToByte(l_pathImage: String): ByteArray {
        var bytesArray = byteArrayOf()
        try {
            val file = File(l_pathImage)

            bytesArray = ByteArray(file.length().toInt())

            val fis = FileInputStream(file)
            fis.read(bytesArray)
            fis.close()
        } catch (e: Exception) {
            e.printStackTrace()
        }

        return bytesArray
    }

    interface DownloadImageListener {
        fun onStartDownload()

        fun onCompleteDownload(bitmap: Bitmap?)

        fun onFailDownload()

        fun onStopDownload()
    }

}
