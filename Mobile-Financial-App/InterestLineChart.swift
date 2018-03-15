//
//  InterestLineChart.swift
//
//  Created by Jason  Wong on 2018-03-14.
//  Copyright © 2018 Jason  Wong. All rights reserved.
//

import UIKit
import Charts

class InterestLineChart: UIView {
    
    let lineChartView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    
    var compoundDuration = [Int]()
    var accumulatedReturn = [Double]()
    
    var delegate: GetChartData! {
        didSet {
            populateData()
            lineChartSetup()
        }
    }
    
    func populateData() {
        compoundDuration = delegate.compoundDuration
        accumulatedReturn = delegate.accumulatedReturn
    }
    
    func lineChartSetup() {
        self.backgroundColor = UIColor.white
        self.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
        setLineChart(dataPoints: compoundDuration, values: accumulatedReturn)
    }
    
    func setLineChart(dataPoints: [Int], values: [Double]) {
        lineChartView.noDataTextColor = UIColor.white
        lineChartView.noDataText = "Input the following form to see how much interest you can get over time"
        lineChartView.backgroundColor = UIColor.white
        
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(Int(i)), y: values[i])
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "Total Investment Return")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.setCircleColor(UIColor.blue)
        chartDataSet.circleHoleColor = UIColor.blue
        chartDataSet.circleRadius = 4.0
        
        // gradient fill
        let gradientColor = [UIColor.blue.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColor, locations: colorLocations) else {
            print("gradient error"); return
        }
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
//        let formatter: ChartFormatter = ChartFormatter()
//        formatter.setValues(values: dataPoints)
        let xaxis:XAxis = XAxis()
     //   xaxis.valueFormatter = formatter
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
      //  lineChartView.xAxis.valueFormatter = xaxis.valueFormatter
        lineChartView.chartDescription?.enabled = false
        lineChartView.legend.enabled = true
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawLabelsEnabled = true
        
        lineChartView.data = chartData
    }
}
