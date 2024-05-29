//
//  GraphicViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 10.05.2024.
//

import UIKit
import Charts
import DGCharts
class GraphicViewController: UIViewController{

    let barChart = BarChartView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    private func setUI(){
        view.addSubview(barChart)
        barChart.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 600)
                
                // Populate the chart with some sample data
                let entries = [
                    BarChartDataEntry(x: 0, y: 5),
                    BarChartDataEntry(x: 1, y: 3),
                    BarChartDataEntry(x: 2, y: 2)
                ]
                let dataSet = BarChartDataSet(entries: entries, label: "Хранения лекарств")
            dataSet.colors = [UIColor.green, UIColor.red, UIColor.blue]
            
            let data = BarChartData(dataSet: dataSet)
            
            barChart.data = data
            
            // Set custom labels for the x-axis
            let labels = ["Таблетки 1-5лет", "Сиропы 1-3год", "Мази и гели 1-2год"]
            barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
            
            // Customize the x-axis
            barChart.xAxis.granularity = 1 // Ensure labels are shown for each bar
            barChart.xAxis.labelPosition = .bottom // Display labels at the bottom
            
            barChart.animate(yAxisDuration: 1.0)
    }
    


}
