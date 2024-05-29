//
//  PreparatsViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 22.04.2024.
//

import UIKit

class PreparatsViewController: UIViewController {
    var onSelection: ((String) -> Void)?
    var selectedPill: String?
    let painTypes = ["БАД Алкогольная", "Витамины. Минеральные вещества", "Гематология. Гемостаз", "Гигиена полости рта", "Гинекология. Акушерство", "Гомеопатические средства", "Дерматология. Внутренние", "Дерматология. Средства для нару...", "Диетическое питание", "Желудочно-кишечные средства","Инфузионная терапия","Косметические средства","Обезболивающие. Противовоспалительные","Противовирусные средства","Противогрибковые средства","Противовирусные средства. Грипп. Простуда","Противопростудные комплексы","Средства от боли в горле","Средства от влажного кашля","Средства от насморка","Увлажнение и очищение носа","Фитосвечи/Воронки ушные","Средства для лечения суставов"]
    let toolbar = UIToolbar()
    lazy var myTableView:UITableView = {
       let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    lazy var cancelButton:UIButton = {
       let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.addTarget(self, action: #selector(cancelSelection), for: .touchUpInside)
        button.backgroundColor = .systemRed
        return button
    }()
    lazy var chooseButton:UIButton = {
       let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(chooseSelection), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private func setUI(){
        view.addSubview(myTableView)
        view.addSubview(toolbar)
        view.addSubview(cancelButton)
        view.addSubview(chooseButton)
        //constraint
        myTableView.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
        }
        toolbar.snp.makeConstraints { make in
                   make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                   make.leading.equalTo(view)
                   make.trailing.equalTo(view)
        }
        cancelButton.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
                    make.right.equalTo(view.snp.centerX).offset(-5)
                    make.height.equalTo(50)
        }
                
        chooseButton.snp.makeConstraints { make in
                    make.right.equalToSuperview()
                    make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
                    make.left.equalTo(view.snp.centerX).offset(5)
                    make.height.equalTo(50)
        }
        
    }
     
}
extension PreparatsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return painTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
               cell.textLabel?.text = painTypes[indexPath.row]
               cell.backgroundColor = selectedPill == painTypes[indexPath.row] ? .lightGray : .white
               return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedPill = painTypes[indexPath.row]
            tableView.reloadData()
        }
    @objc func cancelSelection() {
            self.dismiss(animated: true)
        }
    @objc func chooseSelection() {
            if let selectedPill = selectedPill {
                onSelection?(selectedPill)
            }
            self.dismiss(animated: true)
        }
    
}
