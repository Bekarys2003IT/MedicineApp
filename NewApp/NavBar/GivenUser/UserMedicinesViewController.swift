//
//  UserMedicinesViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 20.05.2024.
//

import UIKit

class UserMedicinesViewController: UIViewController {

    private var ownerEmail: String
        private var medicines: [FirebaseMedicine] = []

        init(ownerEmail: String) {
            self.ownerEmail = ownerEmail
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    private lazy var
    private lazy var sometableView:UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = true
        table.alwaysBounceVertical = true
        table.register(MedicineTableViewCell.self, forCellReuseIdentifier: "MedicineTableViewCell")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
extension UserMedicinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineTableViewCell", for: indexPath) as? MedicineTableViewCell else { return UITableViewCell() }
        let medicine = medicines[indexPath.row]
        cell.typeLabel.text = medicine.type
        cell.medicamentLabel.text = "Медикаменты: \(medicine.pills.count)"
        cell.iconView.image = UIImage(systemName: medicine.iconName)
        cell.backgroundColor = UIColor(red: 154/255, green: 254/255, blue: 128/255, alpha: 1)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMedicine = medicines[indexPath.row]
        let pillsViewController = PillsViewController(medicine: selectedMedicine)
        navigationController?.pushViewController(pillsViewController, animated: true)
    }
}
