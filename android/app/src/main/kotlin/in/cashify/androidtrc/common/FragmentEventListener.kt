package `in`.cashify.androidtrc.common


import `in`.cashify.androidtrc.common.BaseFragment
import androidx.annotation.ColorRes
import androidx.fragment.app.FragmentManager

/**
 * Created by gup on 26/08/2015.
 * FragmentEventListener
 */
interface FragmentEventListener {

    fun addChildFragment(
        fragment: BaseFragment,
        fragmentContainerId: Int,
        manager: FragmentManager,
        addToBackStack: Boolean
    )

    fun addFragment(fragment: BaseFragment, addToBackStack: Boolean)

    fun addFragment(fragment: BaseFragment, containerId: Int, addToBackStack: Boolean)

    fun addFragment(fragment: BaseFragment, addToBackStack: Boolean, enterAnimation: Int, exitAnimation: Int)

    fun addFragment(
        fragment: BaseFragment,
        addToBackStack: Boolean,
        enterAnimation: Int,
        exitAnimation: Int,
        popEnterAnim: Int,
        popExitAnim: Int
    )

    fun replaceFragment(fragment: BaseFragment, addToBackStack: Boolean)

    fun replaceFragment(fragment: BaseFragment, addToBackStack: Boolean, tag: String)

    fun replaceFragment(fragment: BaseFragment, containerId: Int, addToBackStack: Boolean)

    fun replaceFragment(fragment: BaseFragment, addToBackStack: Boolean, enterAnimation: Int, exitAnimation: Int)

    /**
     * @param fragment       to be replaced
     * @param addToBackStack will add to action_next stack of the current transaction,
     * should be false in case of first fragment.
     * @param enterAnimation Set specific animation resources to run for the fragments that are
     * entering in this transaction.
     * @param exitAnimation  Set specific animation resources to run for the fragments that are
     * exiting in this transaction.
     * @param popEnterAnim   The animations will be played for enter/exit
     * operations specifically when popping the action_next stack.
     * @param popExitAnim    The animations will be played for enter/exit
     * operations specifically when popping the action_next stack.
     */
    fun replaceFragment(
        fragment: BaseFragment,
        addToBackStack: Boolean,
        enterAnimation: Int,
        exitAnimation: Int,
        popEnterAnim: Int,
        popExitAnim: Int
    )

    fun showLoading(show: Boolean)

    fun setToolbarTitle(title: String)

    fun setToolbarTitle(name: String, @ColorRes color: Int)

    fun onRetryClicked()

    fun replaceFragment(
        fragment: BaseFragment,
        addToBackStack: Boolean,
        tag: String,
        enterAnimation: Int,
        exitAnimation: Int
    )

    fun downloadDocument(documentUrl: String, saveWithFileName: String, fileType: String)
}