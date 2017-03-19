//
//  ChartViewController.swift
//  Roket
//
//  Created by Rock on 19/03/2017.
//  Copyright © 2017 Rock. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var chartContainerView: UIView!
    @IBAction func dimissButtonTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        weeklyDistanceChart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func weeklyDistanceChart() {
        
        let chart = BarChartView(frame: self.chartContainerView.frame)
        
        //generate chart data entries
        let yVals: [Double] = [ 888,787,999,345 ]
        var entries = [ BarChartDataEntry]()
        for (i, v) in yVals.enumerated() {
            let entry = BarChartDataEntry()
            entry.x = Double( i)
            entry.y = v
            
            entries.append( entry)
        }
        
        //chart setup
        let set = BarChartDataSet( values: entries, label: "Bar Chart")
        let data = BarChartData( dataSet: set)
        chart.data = data
        // no data text
        chart.noDataText = ""
        // user interaction
        chart.isUserInteractionEnabled = false
        
        //style
        chart.drawValueAboveBarEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        
        chart.leftAxis.drawLabelsEnabled = true
        chart.rightAxis.drawLabelsEnabled = false
        //animation
        chart.animate(xAxisDuration:  1.0)
        chart.chartDescription = nil
        
        
        //add chart to UI
        self.chartContainerView.addSubview(chart)
    }
    

    
    
}


