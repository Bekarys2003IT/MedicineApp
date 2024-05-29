//
//  MyPillsViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 14.04.2024.
//
import RealmSwift
import UIKit
import SnapKit
import FirebaseFirestore
protocol MedicineUpdateDelegate: AnyObject {
    func didUpdatePills()
}
class MyPillsViewController: UIViewController {
    var pills:[Pill] = []
    var selectedMedicine: Medicine?
    weak var delegate: MedicineUpdateDelegate?
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "Содержимое аптечки"
        label.textColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    private lazy var firstView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
       return view
    }()
    lazy var medicamentLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.textColor = .blue
        return label
    }()
    lazy var pillsTableView:UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.isScrollEnabled = true
        table.alwaysBounceVertical = true
        table.register(PillsTableViewCell.self, forCellReuseIdentifier: "PillsTableViewCell")
        return table
    }()
    lazy var secondView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
       return view
    }()
    lazy var pillsButton:UIButton = {
       let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.setTitleColor(UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1), for: .normal)
        button.setImage(UIImage(systemName: "pills.fill"), for: .normal)
        button.tintColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.layer.borderColor = .init(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(tapPills), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPills()
        pillsTableView.reloadData()

    }
    private func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(firstView)
        firstView.addSubview(medicamentLabel)
        view.addSubview(pillsTableView)
        view.addSubview(secondView)
        secondView.addSubview(pillsButton)
        
        //constraint
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.centerX.equalToSuperview()
        }
        firstView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(100)
            make.trailing.leading.equalToSuperview()
        }
        medicamentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        pillsTableView.snp.makeConstraints { make in
            make.top.equalTo(firstView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(secondView.snp.top)
        }
        secondView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        pillsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(200)
        }
    }
    private func loadPills() {
        guard let medicine = selectedMedicine else { return }
        pills = Array(medicine.pills)  // Directly use the List<Pill> from the Medicine object
        pillsTableView.reloadData()
    }
    @objc func tapPills(){
        print("Tap Pills")
        let addPillsVC = AddPillsViewController()
            addPillsVC.selectedMedicine = selectedMedicine
            addPillsVC.onMedicineAdded = { [weak self] newPill in
                guard let self = self, let medicine = self.selectedMedicine else { return }
                let realm = try! Realm()
                try! realm.write {
                    realm.add(newPill)
                    medicine.pills.append(newPill)  // Add the pill to the specific medicine
                }
                let firebasePill = FirebasePill(
                    name: newPill.name,
                    expireDate: newPill.expireDate,
                    purchasePrice: newPill.purchasePrice,
                    notice: newPill.notice,
                    iconName: newPill.iconName,
                    illName: newPill.illName
                )
                if let firebaseMedicine = self.convertToFirebaseMedicine(realmMedicine: self.selectedMedicine) {
                            firebaseMedicine.pills.append(firebasePill)
                            MedicineService.shared.updateMedicineWithPills(medicine: firebaseMedicine) { error in
                                if let error = error {
                                    print("Error updating medicine with new pill: \(error)")
                                } else {
                                    print("Pill added successfully to Firestore!")
                                }
                            }
                        }
                
//                saveFirestore(medicine: medicine)
                self.updateMedicamentCount()
                self.pills.append(newPill)
                self.pillsTableView.reloadData()
            }
            delegate?.didUpdatePills()
            NotificationCenter.default.post(name: Notification.Name("PillDataChanged"), object: nil)
            let navigationController = UINavigationController(rootViewController: addPillsVC)
            self.present(navigationController, animated: true, completion: nil)
        }
    func convertToFirebaseMedicine(realmMedicine: Medicine?) -> FirebaseMedicine? {
        guard let realmMedicine = realmMedicine else { return nil }
        let firebasePills = realmMedicine.pills.map { pill -> FirebasePill in
            FirebasePill(
                name: pill.name,
                expireDate: pill.expireDate,
                purchasePrice: pill.purchasePrice,
                notice: pill.notice,
                iconName: pill.iconName,
                illName: pill.illName
            )
        }
        return FirebaseMedicine(
            type: realmMedicine.type,
            medicament: realmMedicine.medicament,
            iconName: realmMedicine.iconName,
            pills: Array(firebasePills)  // Correct usage to convert a LazyMapSequence to Array
        )
    }

        private func updateMedicamentCount() {
            medicamentLabel.text = "Медикаментов в аптечке: \(pills.count + 1)"
        }
       private func decreaseMedicamentCount() {
        medicamentLabel.text = "Медикаментов в аптечке: \(pills.count - 1)"
       }
}
extension MyPillsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pills.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100 // Adjust the height as necessary
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
                detailVC.pill = pills[indexPath.row]
                navigationController?.pushViewController(detailVC, animated: true)
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = pillsTableView.dequeueReusableCell(withIdentifier: "PillsTableViewCell", for: indexPath) as? PillsTableViewCell else {return UITableViewCell()}
        let pill = pills[indexPath.row]
        cell.configure(with: pill)
        cell.nameLabel.text = pill.name
        cell.iconView.image = UIImage(systemName: "pills.circle")
        return cell
    }
    
    //delete tableview
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    //logic of delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard indexPath.row >= 0 && indexPath.row < pills.count else {
                print("Invalid index for deletion: \(indexPath.row)")
                return
            }
            let pillToDelete = pills[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(pillToDelete)
                if let medicine = selectedMedicine {
                    if indexPath.row < medicine.pills.count {
                        medicine.pills.remove(at: indexPath.row)
                    } else {
                        print("Invalid index for pill removal from selected medicine")
                    }
                } else {
                    print("Selected medicine is nil")
                }
            }
            decreaseMedicamentCount()
            pills.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

