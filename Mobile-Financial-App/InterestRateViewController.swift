//
//  InterestRateViewController.swift
//  Mobile-Financial-App
//
//  Created by 21403150 on 2018-03-05.
//  Copyright © 2018 55487145. All rights reserved.
//

import UIKit
import Foundation
import Charts

// TODO: Correct x-axis to integer data
// TODO: Add padding to plot area

protocol GetChartData {
    func getChartData(with dataPoints: [Int], values: [Double])
    var compoundDuration: [Int] {get set}
    var accumulatedReturn: [Double] {get set}
}

class InterestRateViewController: UIViewController, GetChartData {
    
    var compoundDuration = [Int]()
    var accumulatedReturn = [Double]()
    
    @IBOutlet weak var Principal: UITextField!
    @IBOutlet weak var Compound: UITextField!
    @IBOutlet weak var Interest: UITextField!
    @IBOutlet weak var Duration: UITextField!
    @IBOutlet weak var Result: UILabel!
    @IBAction func Execute(_ sender: Any) {
        compoundInterest()
        lineChart()
    }
    
    func compoundInterest() {
        
        compoundDuration = []
        accumulatedReturn = []
        
        var p = Double(Principal.text!)
        let n = Double(Compound.text!)
        let r = Double(Double(Interest.text!)! / 100)
        let T = Double(Duration.text!)
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let numberOfYears = Int(T!)
        
        compoundDuration.append(1)
        accumulatedReturn.append(p!)
        
        for i in year ... (year + numberOfYears - 1) {
            compoundDuration.append(i + 1)
            let tmp = Double(p! * (pow((r/n!) + 1, n!)))
            accumulatedReturn.append(tmp)
            p = tmp
        }
        self.getChartData(with: compoundDuration, values: accumulatedReturn)
        Result.text = String(p!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func lineChart() {
        let plot = CGRect(x: 0.0, y: 30.0, width: self.view.frame.width, height: (self.view.frame.height / 1.9)).insetBy(dx: 0, dy: 20)
        let lineChart = InterestLineChart(frame: plot)
        lineChart.delegate = self
        self.view.addSubview(lineChart)
    }
    
    func getChartData(with dataPoints: [Int], values: [Double]) {
        self.compoundDuration = dataPoints
        self.accumulatedReturn = values
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var compoundDuration = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return compoundDuration[Int(value)] // index out of range error
    }
}

