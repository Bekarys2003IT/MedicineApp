//
//  APIViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 06.05.2024.
//

import UIKit

class APIViewController: UIViewController {

    private lazy var label:UILabel = {
       let label = UILabel()
        label.text = "Drugs API"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        return label
    }()
    
    private let safetyReportLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    private func setUI(){
        view.addSubview(label)
        view.addSubview(safetyReportLabel)
        
        //constraint
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        safetyReportLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(60)
                    make.centerX.equalToSuperview()
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.equalToSuperview().offset(-20)
                }
                safetyReportLabel.numberOfLines = 0
                safetyReportLabel.textAlignment = .center

        loadSafetyReportData()
    }
    func updateSafetyReportUI(report: SafetyReport) {
            safetyReportLabel.text = """
            Safety Report ID: \(report.safetyreportid)
            Serious: \(report.serious)
            Serious Death: \(report.seriousnessdeath)
            Reporter Country: \(report.primarysource.reportercountry)
            Drug: \(report.patient.drug.first?.medicinalproduct ?? "Unknown")
            Reaction: \(report.patient.reaction.first?.reactionmeddrapt ?? "Unknown")
            """
        
        
        }

        
    func loadSafetyReportData() {
        NetworkManager.shared.fetchSafetyReport { [weak self] result in
            guard let self = self else { return }
            guard let reports = try? result.get(), let firstReport = reports.first else {
                // Handle the error or case where no report is available
                print("Error: Unable to fetch safety report data or no reports found.")
                return
            }
            // Update the UI on the main thread with the first safety report
            DispatchQueue.main.async {
                self.updateSafetyReportUI(report: firstReport)
            }
        }
        
        
    }
}
