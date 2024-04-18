//
//  MedicineViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 11.04.2024.
//

import UIKit
import RealmSwift
class MedicineViewController: UIViewController {
    var medicines:[Medicine] = []
    var medicamentCount = 0
    let realm = try! Realm()
    lazy var myMedicineLabel:UILabel = {
        let label = UILabel()
        label.text = "Мои аптечки"
        label.font = .systemFont(ofSize: 20,weight: .bold)
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        return label
    }()
    lazy var grayView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var medicineCountLabel:UILabel = {
        let label = UILabel()
        label.text = "Аптечек:"
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        return label
    }()
    lazy var favoritesButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "basket"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tapFavorites), for: .touchUpInside)
        return button
    }()
    lazy var sometableView:UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = true
        table.alwaysBounceVertical = true
        table.register(MedicineTableViewCell.self, forCellReuseIdentifier: "MedicineTableViewCell")
        return table
    }()
    lazy var secondGrayView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    lazy var createMedicineButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cross.case.fill"), for: .normal)
        button.setTitle("Создать аптечку", for: .normal)
        button.setTitleColor(UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1), for: .normal)
        button.tintColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = .init(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        button.addTarget(self, action: #selector(addMedicine), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(Realm.Configuration.defaultConfiguration.fileURL)
        setUI()
    }
    private func setUI(){
        view.addSubview(myMedicineLabel)
        view.addSubview(grayView)
        grayView.addSubview(medicineCountLabel)
        grayView.addSubview(favoritesButton)
        view.addSubview(sometableView)
        view.addSubview(secondGrayView)
        secondGrayView.addSubview(createMedicineButton)
        
        //constraint
        myMedicineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        grayView.snp.makeConstraints { make in
            make.top.equalTo(myMedicineLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        medicineCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        favoritesButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(25)
            make.height.equalTo(50)
            make.width.equalTo(60)
        }
        sometableView.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(secondGrayView.snp.top)
        }
        secondGrayView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.leading.trailing.equalToSuperview() // Again, ensuring full width
            make.height.equalTo(100)
        }
        createMedicineButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(200)
        }
        
    }
    
    @objc func addMedicine(){
        print("addmedicine tapped")
        let newMedicine = Medicine()
        newMedicine.type = "Домашняя"
        newMedicine.medicament = "\(medicamentCount)"  // Assuming this is just a descriptive field
        newMedicine.iconName = "cross.case.fill"
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(newMedicine)
        }
        medicamentCount += 1
        loadMedicines()
    }
    
    private func loadMedicines() {
        let realm = try! Realm()
        medicines = Array(realm.objects(Medicine.self))  // Load all medicines
        sometableView.reloadData()
    }
    @objc func tapFavorites(){
        print("Favorites tapped")
    }
    


}
extension MedicineViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100 // Adjust the height as necessary
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = sometableView.dequeueReusableCell(withIdentifier: "MedicineTableViewCell", for: indexPath) as? MedicineTableViewCell else { return UITableViewCell() }
           let medicine = medicines[indexPath.row]
           cell.typeLabel.text = medicine.type
           cell.medicamentLabel.text = "Медикаменты: \(medicine.medicament)"
           cell.iconView.image = UIImage(systemName: medicine.iconName)
           cell.backgroundColor = UIColor(red: 154/255, green: 254/255, blue: 128/255, alpha: 1)
           return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMedicine = medicines[indexPath.row]
        let pillsViewController = MyPillsViewController()
        pillsViewController.selectedMedicine = selectedMedicine
        navigationController?.pushViewController(pillsViewController, animated: true)
    }
    //delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //logic of delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let medicineToDelete = medicines[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(medicineToDelete)
            }
            medicines.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}

