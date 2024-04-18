//
//  DetailViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 14.04.2024.
//

import UIKit
import RealmSwift
class DetailViewController: UIViewController {
    var pill: Pill?
    let realm = try! Realm()
    lazy var nameTextField:UITextField = {
       let field = UITextField()
        field.placeholder = "Enter the name of medicine"
        field.borderStyle = .roundedRect
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    lazy var expireDatePicker:UIDatePicker = {
       let date = UIDatePicker()
        date.datePickerMode = .date
        date.preferredDatePickerStyle = .wheels
        return date
    }()
    lazy var purchasePriceTextField:UITextField = {
       let field = UITextField()
        field.placeholder = "Enter the price"
        field.borderStyle = .roundedRect
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    lazy var noticeTextField:UITextField = {
       let field = UITextField()
        field.placeholder = "Notice of pills"
        field.keyboardType = .decimalPad
        field.borderStyle = .roundedRect
        field.layer.borderColor = UIColor.black.cgColor
        return field
    }()
    lazy var firstView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 154/255, green: 254/255, blue: 128/255, alpha: 1)
        return view
    }()
    lazy var saveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .lightGray
        button.layer.borderColor = .init(gray: 70, alpha: 1)
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(saveMedicine), for: .touchUpInside)
        return button
    }()
    
       
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        setUI()
        populateUI()
    }
    private func setUI(){
        view.addSubview(nameTextField)
        view.addSubview(expireDatePicker)
        view.addSubview(purchasePriceTextField)
        view.addSubview(noticeTextField)
        view.addSubview(firstView)
        firstView.addSubview(saveButton)
        
        //constraint
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(350)
        }
        expireDatePicker.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(350)
        }
        purchasePriceTextField.snp.makeConstraints { make in
            make.top.equalTo(expireDatePicker.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(350)
        }
        noticeTextField.snp.makeConstraints { make in
            make.top.equalTo(purchasePriceTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(350)
        }
        firstView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(100)
            
        }
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.width.equalTo(150)
        }
        
    }
    func populateUI() {
        guard let pill = pill else { return }
        nameTextField.text = pill.name
        expireDatePicker.date = pill.expireDate
        purchasePriceTextField.text = pill.purchasePrice
        noticeTextField.text = pill.notice
    }
   

}
extension DetailViewController {
    @objc func saveMedicine() {
        if nameTextField.text?.isEmpty == true {
            showAlert()
        } else if purchasePriceTextField.text?.isEmpty == true{
            showAlert()
        } else if purchasePriceTextField.text?.isEmpty == true{
          showAlert()
        }
        updatePill()
    }
    private func updatePill() {
        guard let pill = pill else {return}
        try! realm.write {
            pill.name = nameTextField.text ?? pill.name
            pill.expireDate = expireDatePicker.date
            pill.purchasePrice = purchasePriceTextField.text ?? pill.purchasePrice
            pill.notice = noticeTextField.text ?? pill.notice
        }
        navigationController?.pushViewController(MyPillsViewController(), animated: true)
    }
    private func showAlert(){
        let alert = UIAlertController(title: "Error!", message: "Please fill all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert,animated: true)
    }
}
