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
    @IBAction func Execute(_ sender: Any) {
        checkSubViewAlreadyExist()
        compoundInterest()
        lineChart()
    }
    @IBOutlet weak var Result: UILabel!
    
    func compoundInterest() {
        
        compoundDuration = []
        accumulatedReturn = []
        if(Principal==nil||Compound==nil||Interest==nil||Duration==nil){
            Result.text = "must have variables!"
            
        } else {

            Principal.text! = (Principal.text?.replacingOccurrences(of: " ", with: ""))!
            Compound.text! = (Compound.text?.replacingOccurrences(of: " ", with: ""))!
            Interest.text! = (Interest.text?.replacingOccurrences(of: " ", with: ""))!
            Duration.text! = (Duration.text?.replacingOccurrences(of: " ", with: ""))!

            let countdots = Principal.text!
            let cont = countdots.components(separatedBy:".")
            let x = cont.count-1
            
            if x > 1 || Principal.text! == "."
            {
                Result.text = "dots!"
            } else {
                
                Principal.text! = remove(text: (Principal.text)!)
                Compound.text! = remove(text: (Compound.text)!)
                Interest.text! = remove(text: (Interest.text)!)
                Duration.text! = remove(text: (Duration.text)!)
                
                if((Principal.text)==""||(Compound.text)==""||(Interest.text)==""||(Duration.text)==""){
                    Result.text = "check your variables!"
                    
                }else{
                    
                    var p = Double(Principal.text!)
                    let n = Double(Compound.text!)
                    let r = Double(Double(Interest.text!)! / 100)
                    let T = Double(Duration.text!)
                    let test = 0.0;
                   
                  
                    
                    if(p!>=test||n!>=test||r>=test||T!>=test){
                        let initialPrincipal = String(p!)
                        
                        let date = Date()
                        let calendar = Calendar.current
                        let year = calendar.component(.year, from: date)
                        let numberOfYears = Int(T!)
                        print(numberOfYears);
                        compoundDuration.append(1)
                        accumulatedReturn.append(p!)
                        
                        for i in year ... (year + numberOfYears - 1) {
                            compoundDuration.append(i + 1)
                            let tmp = Double(p! * (pow((r/n!) + 1, n!)))
                            accumulatedReturn.append(tmp)
                            p = tmp
                        }
                        self.getChartData(with: compoundDuration, values: accumulatedReturn)
                        
                        let finalInvestment = String(Double(round(100 * p!) / 100))
                        
                        let textMessage = "Invested with an initial principal of $\(initialPrincipal) with an interest rate of \(r * 100)% compounding \(String(Int(n!))) times per annum over \(String(Int(T!))) years, you will end up with $\(finalInvestment)"
                        
                        Result.text = textMessage
                    }else{
                        Result.text = "Wrong input in the variables, no negative!"
                    }
                }
            }
        }
    }
    
    func remove(text: String) -> String {
        let okayChars : Set<Character> =
            Set(" 1234567890.".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
    }
    
    func lineChart() {
        let plot = CGRect(x: 23.0,
                          y: (self.view.frame.height - (self.view.frame.height / 1.95)),
                          width: self.view.frame.width * 0.9,
                          height: (self.view.frame.height / 1.98)).insetBy(dx: 0, dy: 20)
        let lineChart = InterestLineChart(frame: plot)
        lineChart.delegate = self
        self.view.addSubview(lineChart)
    }
    
    func getChartData(with dataPoints: [Int], values: [Double]) {
        self.compoundDuration = dataPoints
        self.accumulatedReturn = values
    }
    
    func checkSubViewAlreadyExist() {
        for v in self.view.subviews {
            if v is InterestLineChart {
                v.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var compoundDuration = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return compoundDuration[Int(value)]
    }
}

