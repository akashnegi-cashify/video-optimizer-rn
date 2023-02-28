package `in`.cashify.androidtrc.common

import `in`.cashify.androidtrc.MainActivity
import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.BaseAPICallback
import `in`.cashify.androidtrc.common.fragment.NoInternetFragment
import `in`.cashify.androidtrc.databinding.ActivityBaseBinding
import `in`.cashify.androidtrc.module.login.ChangePasswordActivity
import `in`.cashify.androidtrc.module.login.api.LogOutResponse
import `in`.cashify.androidtrc.module.login.api.LoginModuleApi
import `in`.cashify.androidtrc.module.storageManager.ui.activity.StoreInActivity
import `in`.cashify.androidtrc.module.storageManager.ui.activity.StoreOutActivity
import `in`.cashify.androidtrc.util.ActivityHelper
import `in`.cashify.androidtrc.util.AppUtils
import `in`.cashify.androidtrc.util.TrcProgressDialog
import `in`.reglobe.api.kotlin.exception.APIException
import android.app.ActivityManager
import android.content.*
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.os.Bundle
import android.util.Log
import android.view.MenuItem
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.annotation.LayoutRes
import androidx.appcompat.app.ActionBarDrawerToggle
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.widget.PopupMenu
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.FragmentActivity
import androidx.lifecycle.ViewModelProvider
import dagger.android.support.DaggerAppCompatActivity
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject
import kotlin.math.log


abstract class BaseActivity : DaggerAppCompatActivity(), ActivityListener {


    private var mDialog: TrcProgressDialog? = null

    @Inject
    lateinit var mActivityHelper: ActivityHelper


    @Inject
    lateinit var mAppUtils: AppUtils

    @Inject
    lateinit var factory: ViewModelProvider.Factory

    lateinit var baseBinding: ActivityBaseBinding


    var actionBarDrawerToggle: ActionBarDrawerToggle? = null

    final override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        AppInfoProvider.getInstance().init(mPreferenceUtils)
        baseBinding = DataBindingUtil.inflate(layoutInflater, R.layout.activity_base, null, false)
        baseBinding.lifecycleOwner = this
        setContentView(baseBinding.root)
        initToolBar()
        if (isShowNavDrawer()) {
            initNavDrawer()
        }

        setTitle(getString(R.string.app_name))
        getLayoutResId()
        create(savedInstanceState, baseBinding.mainContainer, true)

    }


    protected open fun initNavDrawer() {


        actionBarDrawerToggle =
            ActionBarDrawerToggle(
                this,
                baseBinding.myDrawerLayout,
                R.string.navigation_drawer_open,
                R.string.navigation_drawer_close
            )

        actionBarDrawerToggle?.let {
            baseBinding.myDrawerLayout.addDrawerListener(it)
            actionBarDrawerToggle?.syncState()
            getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        }



        baseBinding.tvChangePass.setOnClickListener {

            startActivity(Intent(this, ChangePasswordActivity::class.java))

        }


        baseBinding.tvLogout.setOnClickListener {
            showLogOutAlert()
        }

        try {
            val pInfo: PackageInfo = getPackageManager().getPackageInfo(getPackageName(), 0)
            val version = pInfo.versionName
            baseBinding.tvVersion.setText(
                String.format(
                    resources.getString(R.string.app_version),
                    version
                )
            )

        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
        baseBinding.navView.getHeaderView(0).findViewById<TextView>(R.id.tv_user).setText(
            String.format(
                resources.getString(R.string.hi_user),
                AppInfoProvider.getInstance().getUserDetailResponse()?.userName
            )
        )


    }

    private fun initToolBar() {
        if (hasActionBar()) {
            setSupportActionBar(baseBinding.toolbar)
        } else {
            baseBinding.toolbar.visibility = View.GONE
        }
        if (AppInfoProvider.getInstance().isUserLogin && isShowLogoutButton()) {
            baseBinding.btnLogOut.visibility = View.VISIBLE
        } else {
            baseBinding.btnLogOut.visibility = View.GONE
        }

        baseBinding.drawer.visibility = View.GONE

        baseBinding.btnLogOut.setOnClickListener {
            showPopUpMenu()
        }
    }


    fun handleStoreOut() {
        val intent = Intent(this, StoreOutActivity::class.java)
        startActivity(intent)

    }


    protected fun handleStoreIn() {

        val intent = Intent(this, StoreInActivity::class.java)
        startActivity(intent)

    }

    private fun showPopUpMenu() {
        val popup = PopupMenu(this, baseBinding.btnLogOut)

        popup.menuInflater
            .inflate(R.menu.pop_up_menu, popup.menu)

        popup.setOnMenuItemClickListener { item ->
            when (item.itemId) {
                R.id.log_out -> {
                    showLogOutAlert()
                }
                R.id.change_password -> {
                    startActivity(Intent(this, ChangePasswordActivity::class.java))
                }
            }
            true
        }

        popup.show()
    }


    override fun setTitle(title: String?) {
        baseBinding.tvTitle.text = title
    }

    private fun showLogOutAlert() {
        val alertDialog = AlertDialog.Builder(this)
        alertDialog.setTitle("Log out...")
        alertDialog.setMessage(
            AppInfoProvider.getInstance().getUserName() + ", Do you want to log out" + "?"
        )
        alertDialog.setPositiveButton(
            "OK"
        ) { _, _ -> logOut() }
        alertDialog.setNegativeButton("Cancel") { _, _ -> }
        alertDialog.show()
    }


    private fun logOut() {
        showLoading(true)
        val service = UserModuleService<LoginModuleApi, LogOutResponse>(
            LoginModuleApi::class.java,
            this
        )

        service.execute(object : BaseAPICallback<LoginModuleApi, LogOutResponse>() {
            override fun onSuccess(response: LogOutResponse, rawResponse: Response) {
                if (response.success == 1) {
                    showLoading(false)
                    destroyLoginSession()
                } else {
                    showLogOutAlert()
                }
            }

            override fun onFailure(e: APIException) {
                showError(getErrorMsg(e))
            }

            override fun onComplete() {
                showLoading(false)
            }

            override fun getAPIAsync(api: LoginModuleApi): Deferred<retrofit2.Response<LogOutResponse>> {
                return api.logoutAsync()
            }
        })
    }

    fun getErrorMsg(apiError: APIException?): String? {
        var errMsg: String? = "Something went wrong"
        if (apiError?.error != null) {
            errMsg = apiError.error?.message
        } else if (apiError != null) {
            errMsg = apiError.message
        }
        return errMsg ?: "Something went wrong"
    }

    @LayoutRes
    abstract fun getLayoutResId(): Int


    open fun hasActionBar(): Boolean {
        return true
    }

    abstract fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    )


    override fun showLoading(isShow: Boolean) {
        if (isFinishing) {
            return
        }



        if (!isShow) {
            if (mDialog != null) {
                mDialog?.dismiss()
                mDialog = null
            }
            return
        }

        if (mDialog == null) {
            mDialog = TrcProgressDialog()
        }
        mDialog?.isCancelable = false
        mDialog?.show(supportFragmentManager, "loading_dialog")

    }

    override fun onOptionsItemSelected(menuItem: MenuItem): Boolean {
        if (menuItem.getItemId() == android.R.id.home) {
            onBackPressed()
        }
        return super.onOptionsItemSelected(menuItem)
    }


    protected val mIntentFilter = IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION)
    protected val mConnectionDetector = ConnectionDetector()

    protected inner class ConnectionDetector : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val notConnected =
                intent.getBooleanExtra(ConnectivityManager.EXTRA_NO_CONNECTIVITY, false)
            if (getContainerId() > 0) {
                if (notConnected) {
                    supportFragmentManager.beginTransaction()
                        .add(getContainerId(), NoInternetFragment.newInstance(), "no_internet")
                        .commitNow()
                } else {
                    val noInternet = supportFragmentManager.findFragmentById(getContainerId())
                    if (noInternet != null && noInternet is NoInternetFragment) {
                        supportFragmentManager.beginTransaction().remove(noInternet).commitNow()
                        onInternetConnected()
                    }


                }
                return
            }
        }
    }

    open fun getContainerId(): Int {
        return -1
    }

    open fun onInternetConnected() {

        val currentFragment = supportFragmentManager.findFragmentById(getContainerId())
        if (currentFragment != null) {
            supportFragmentManager.beginTransaction().detach(currentFragment)
                .attach(currentFragment).commitNow()
        }
    }

    override fun onResume() {
        super.onResume()
        registerReceiver(mConnectionDetector, mIntentFilter)
    }

    override fun onPause() {
        super.onPause()
        unregisterReceiver(mConnectionDetector)
    }

    override fun sessionExpire() {
        showWarningDialog(
            "Login Again", getString(R.string.SESSION_HAS_EXPIRED),
            DialogInterface.OnClickListener { _, _ -> destroyLoginSession() }, "",
            null
        )
    }

    override fun showError(msg: String?) {
        showWarningDialog(msg, "Ok", null, null, null)
    }

    private fun destroyLoginSession() {
//        MainActivity.callLogout()
        AppInfoProvider.getInstance().destroySession()
        launchLoginActivity()
    }

    override fun showDialog(
        title: String?,
        msg: String?,
        positiveButtonText: String?,
        onPositiveClick: DialogInterface.OnClickListener?, negButtonText: String?,
        onNegativeClick: DialogInterface.OnClickListener?
    ) {
        val builder = AlertDialog.Builder(this)
        builder.setTitle(title)
            .setMessage(msg)
            .setPositiveButton(positiveButtonText, onPositiveClick)
            .setNegativeButton(negButtonText, onNegativeClick)
            .setCancelable(false)
        val alertDialog = builder.create()
        alertDialog.show()
    }

    fun showAlertDialog(
        msg: String?,
        positiveButtonText: String?,
        onPositiveClick: DialogInterface.OnClickListener?,
        negButtonText: String?,
        onNegativeClick: DialogInterface.OnClickListener?
    ) {
        showDialog(
            "Alert",
            msg,
            positiveButtonText,
            onPositiveClick,
            negButtonText,
            onNegativeClick
        )
    }

    fun showWarningDialog(
        msg: String?,
        positiveButtonText: String?,
        onPositiveClick: DialogInterface.OnClickListener?, negButtonText: String?,
        onNegativeClick: DialogInterface.OnClickListener?
    ) {
        showDialog(
            "Warning",
            msg,
            positiveButtonText,
            onPositiveClick,
            negButtonText,
            onNegativeClick
        )
    }

    private fun launchLoginActivity() {
        MainActivity.callLogout().let {
            val intent = Intent(this, MainActivity::class.java)
//            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK)
            startActivity(intent)
        }
    }

    fun showBottomDialog(
        activity: FragmentActivity?,
        alertDialogFragment: DialogFragment?,
        tagName: String
    ) {
        val manager = activity!!.supportFragmentManager
        if (alertDialogFragment == null) {
            return
        }
        val fragmentByTag = manager.findFragmentByTag(tagName)
        if (fragmentByTag != null) {
            return
        }
        val transaction = manager.beginTransaction()
        transaction.add(alertDialogFragment, tagName)
        transaction.commitAllowingStateLoss()
    }

    private fun logOutForFlutter(): Boolean {


        val am: ActivityManager = this.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

        val taskList: List<ActivityManager.RunningTaskInfo> = am.getRunningTasks(10)

        if (taskList.size == 1 && taskList[0].topActivity!!.className.contains("InventoryManagerActivity")) {
            return true;
        }
        return false;


    }

    override fun onBackPressed() {
        if (logOutForFlutter()) {
            this.finishAffinity();
            return
        }
        super.onBackPressed()
    }


    protected open fun isShowNavDrawer(): Boolean {
        return false
    }


    protected open fun isShowLogoutButton(): Boolean {
        return true
    }

}