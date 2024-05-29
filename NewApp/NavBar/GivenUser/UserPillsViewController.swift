////
////  UserPillsViewController.swift
////  NewApp
////
////  Created by Бекарыс Сандыгали on 20.05.2024.
////
//
//import UIKit
//
//class UserPillsViewController: UIViewController {
//    private var medicine: FirebaseMedicine
//
//       init(medicine: FirebaseMedicine) {
//           self.medicine = medicine
//           super.init(nibName: nil, bundle: nil)
//       }
//
//       required init?(coder: NSCoder) {
//           fatalError("init(coder:) has not been implemented")
//       }
//    private lazy var titleLabel:UILabel = {
//        let label = UILabel()
//        label.text = "Pills"
//        label.font = .systemFont(ofSize: 25, weight: .bold)
//        return label
//    }()
//   private lazy var userPillsTableView:UITableView = {
//       let table = UITableView()
//        table.delegate = self
//        table.dataSource = self
//        table.isScrollEnabled = true
//        table.alwaysBounceVertical = true
//        table.register(PillsTableViewCell.self, forCellReuseIdentifier: "PillsTableViewCell")
//        return table
//    }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setUI()
//    }
//    private func setUI(){
//        view.addSubview(titleLabel)
//        view.addSubview(userPillsTableView)
//        
//        //constraint
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(130)
//            make.centerX.equalToSuperview()
//        }
//        userPillsTableView.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-30)
//        }
//    }
//   
//    
//}
//extension UserPillsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return medicine.pills.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PillsTableViewCell", for: indexPath) as? PillsTableViewCell else { return UITableViewCell() }
//    
//                return cell
//     
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let detailVC = DetailViewController()
//                detailVC.pill = pill
//                navigationController?.pushViewController(detailVC, animated: true)
//    }
//}
