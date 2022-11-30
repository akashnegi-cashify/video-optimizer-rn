package `in`.cashify.androidtrc.module.engineer.view_report.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.DateUtils
import `in`.cashify.androidtrc.databinding.FragmentViewPartReportBinding
import `in`.cashify.androidtrc.module.engineer.view_report.api.EngineerPartReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.LeadEngineerPartReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.data.ViewReportViewModel
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.ImageView
import android.widget.TextView
import androidx.databinding.DataBindingUtil
import java.util.*
import kotlin.collections.ArrayList


class ViewPartReportFragment : BaseFragment() {
    lateinit var binding: FragmentViewPartReportBinding
    var activityViewModel: ViewReportViewModel? = null

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_view_part_report,
            container,
            false
        )
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setSpinner()
        binding.etStart.isEnabled = false
        binding.etEnd.isEnabled = false

//        binding.etStart.setText(Utils.getTodayDate())
//        binding.etEnd.setText(Utils.getTodayDate())

        binding.calendar.maxDate = Date().time

        binding.calendar.setOnDateChangeListener { view, year, month, dayOfMonth ->
            if (binding.layStart.background.constantState == resources.getDrawable(
                    R.drawable.teal_strock_rect,
                    null
                ).constantState
            ) {

                binding.etStart.setText("${dayOfMonth}/${month + 1}/${year}")
                binding.layEnd.background = resources.getDrawable(R.drawable.teal_strock_rect, null)
                binding.layStart.background =
                    resources.getDrawable(R.drawable.black_strock_rect, null)
                val calendar = Calendar.getInstance()
                calendar.set(Calendar.YEAR, year)
                calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth)
                calendar.set(Calendar.MONTH, month)

                binding.calendar.minDate = calendar.time.time

            } else if (binding.layEnd.background.constantState == resources.getDrawable(
                    R.drawable.teal_strock_rect,
                    null
                ).constantState
            ) {
                binding.etEnd.setText("${dayOfMonth}/${month + 1}/${year}")

                getReport(binding.etStart.text.toString(), binding.etEnd.text.toString())


                binding.calendar.visibility = View.GONE


            }


//            binding.layStart.background = resources.getDrawable(R.drawable.teal_strock_rect , null)
//            binding.layEnd.background = resources.getDrawable(R.drawable.black_strock_rect , null)


        }



        activityViewModel = getActivityViewModel(ViewReportViewModel::class.java)
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner


        activityViewModel?.hidePartReportLoading?.observe(
            viewLifecycleOwner,
            androidx.lifecycle.Observer {
                if (it) {
                    binding.progressbar.visibility = View.GONE
                } else {
                    binding.progressbar.visibility = View.VISIBLE
                }
            })





        activityViewModel?.leadEngineerPartReport(
            object : OnResult<LeadEngineerPartReportResponse> {
                override fun onResultAvailable(data: LeadEngineerPartReportResponse) {
                    binding.etAvgPartCostName.setText(data.data?.leadEngineerPartCost?.engineerName)
                    binding.avgPartConsumptnName.setText(data.data?.leadEngineerPartConsumption?.engineerName)



                    binding.etAvgPartCostValue.setText(String.format(getString(R.string.text_price), data.data?.leadEngineerPartCost?.partCost.toString()))
                    binding.etAvgPartConsumptnValue.setText(data.data?.leadEngineerPartConsumption?.partConsumption.toString())


                }
            })


    }


    private fun getReport(startDate: String, endDate: String) {
        activityViewModel?.partReport(startDate, endDate,
            object : OnResult<EngineerPartReportResponse> {
                override fun onResultAvailable(data: EngineerPartReportResponse) {
                    binding.layTime.visibility = View.GONE


                    binding.tvPartCost.text =  String.format(getString(R.string.text_price), data?.data?.avgPartCost.toString())
                    binding.tvPartConsumptn.text = data?.data?.avgPartConsumption.toString()

                    val pieData: ArrayList<Pair<String, Float>> = ArrayList()
                    pieData.add(
                        Pair(
                            resources.getString(R.string.parts_assigned),
                            data.data?.partsAssign?.toFloat() ?: 0f
                        )
                    )
                    pieData.add(
                        Pair(
                            resources.getString(R.string.parts_consume),
                            data.data?.partsConsume?.toFloat() ?: 0f
                        )
                    )
                    pieData.add(
                        Pair(
                            resources.getString(R.string.parts_return),
                            data.data?.partsReturn?.toFloat() ?: 0f
                        )
                    )
                    pieData.add(
                        Pair(
                            resources.getString(R.string.parts_requested),
                            data.data?.partsRequested?.toFloat() ?: 0f
                        )
                    )


//                    binding.pieChart.setCenterColor(R.color.white)
                    binding.pieChart.setDataPoints(
                        floatArrayOf(
                            pieData.get(0).second,
                            pieData.get(1).second,
                            pieData.get(2).second,
                            pieData.get(3).second
                        )
                    )


                    val colorArray = intArrayOf(
                        R.color.parts_assign,
                        R.color.parts_consume,
                        R.color.parts_return,
                        R.color.parts_requested
                    )
                    binding.pieChart.setSliceColor(
                        colorArray
                    )


                    binding.pieDesc.removeAllViews()

                    for (i in 0..pieData.size) {

                        val v = layoutInflater.inflate(R.layout.lay_pie_desc, null)
                        v.findViewById<ImageView>(R.id.img)
                            .setBackgroundColor(resources.getColor(colorArray[i]))
                        v.findViewById<TextView>(R.id.tv_desc).text = pieData.get(i).first
                        v.findViewById<TextView>(R.id.tv_quantity).text =
                            pieData.get(i).second.toInt().toString()
                        binding.pieDesc.addView(v)

                    }


                }
            })
    }

    fun setSpinner() {

        if (activity == null) {
            return
        }


        val spinnerArrayAdapter = ArrayAdapter(
            activity!!, android.R.layout.simple_spinner_item,
            arrayOf("Yesterday", "Last week" , "This Month" , "Last Month" , "Custom")
        ) //selected item will look like a spinner set from XML
        spinnerArrayAdapter.setDropDownViewResource(
            android.R.layout
                .simple_spinner_dropdown_item
        )
        binding.spinnerTime.adapter = spinnerArrayAdapter



        binding.spinnerTime.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onNothingSelected(parent: AdapterView<*>?) {

            }


            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {
                if (position == 0) {

                    getReport(DateUtils.getYesterdayDate(), DateUtils.getYesterdayDate())
                    binding.calendar.visibility = View.GONE
                    binding.layTime.visibility = View.GONE

                }

                else if(position == 1){
                    getReport(DateUtils.getDateByDay(7),DateUtils.getYesterdayDate())
                    binding.calendar.visibility = View.GONE
                    binding.layTime.visibility = View.GONE
                }

                else if(position == 2){

                    getReport(DateUtils.firstDayMonth(),DateUtils.getTodayDate())
                    binding.calendar.visibility = View.GONE
                    binding.layTime.visibility = View.GONE



                }

                else if(position == 3){
                    getReport(DateUtils.dateOfFirstDayOfLastMonth(),DateUtils.dateOfLastDayOfLastMonth())
                    binding.calendar.visibility = View.GONE
                    binding.layTime.visibility = View.GONE
                }



                else if (position == 4) {
                    val calendar = Calendar.getInstance()
                    calendar.set(Calendar.YEAR, Calendar.getInstance().get(Calendar.YEAR) - 30)


                    binding.calendar.minDate = calendar.time.time
                    binding.layTime.visibility = View.VISIBLE
                    binding.layStart.background =
                        resources.getDrawable(R.drawable.teal_strock_rect, null)
                    binding.layEnd.background =
                        resources.getDrawable(R.drawable.black_strock_rect, null)
                    binding.calendar.visibility = View.VISIBLE

                }

            }

        }
    }


    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment ViewReportFragment.
         */
        // TODO: Rename and change types and number of parameters

        fun newInstance(): ViewPartReportFragment {
            return ViewPartReportFragment()

        }
    }
}