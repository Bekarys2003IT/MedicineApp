//
//  DetailViewController.swift
//  NewApp
//
//  Created by Бекарыс Сандыгали on 14.04.2024.
//

import UIKit
import RealmSwift
class DetailViewController: UIViewController, UIScrollViewDelegate {
    var pill: Pill?
    var onUpdatePill: (() -> Void)?
    var selectedIllName: String?
    lazy var realm: Realm = {
            do {
                return try Realm()
            } catch {
            // Handle errors appropriately, e.g., show an alert or log to console
            fatalError("Realm initialization error: \(error.localizedDescription)")
            }
        }()
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.delegate = self
//        scrollView.showsVerticalScrollIndicator = true
//        return scrollView
//    }()
//    lazy var contentView: UIView = {
//            let view = UIView()
//            return view
//        }()
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
    lazy var badButton:BadButton = {
        let button = BadButton()
        button.setTitle("Лекарственные препараты и БАДы", for: .normal)
        button.setImage(UIImage(systemName: "pills.fill"), for: .normal)
        button.setImageSize(CGSize(width: 40, height: 40))
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 22/255, green: 137/255, blue: 72/255, alpha: 1)
        button.layer.borderColor = UIColor.black.cgColor
        button.titleLabel?.numberOfLines = 0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -button.imageView!.frame.size.width, bottom: -button.imageView!.frame.size.height, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: -button.titleLabel!.frame.size.height, left: 0, bottom: 0, right: -button.titleLabel!.frame.size.width)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(badTap), for: .touchUpInside)
        return button
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
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        print("ScrollView content size: \(scrollView.contentSize)")
//        print("ScrollView frame size: \(scrollView.frame.size)")
//    }
    private func setUI(){
        view.addSubview(nameTextField)
        view.addSubview(expireDatePicker)
        view.addSubview(purchasePriceTextField)
        view.addSubview(badButton)
        view.addSubview(noticeTextField)
        view.addSubview(firstView)
        firstView.addSubview(saveButton)
        
        //constraint
//        scrollView.snp.makeConstraints { make in
//                    make.edges.equalTo(view.safeAreaLayoutGuide)
//                }
//
//        contentView.snp.makeConstraints { make in
//            make.top.bottom.leading.trailing.equalToSuperview()
//                    make.width.equalTo(scrollView)
//        }
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
        badButton.snp.makeConstraints { make in
            make.top.equalTo(purchasePriceTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(350)
        }
        noticeTextField.snp.makeConstraints { make in
            make.top.equalTo(badButton.snp.bottom).offset(20)
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
        do{
            try! realm.write {
                pill.name = nameTextField.text ?? pill.name
                pill.expireDate = expireDatePicker.date
                pill.purchasePrice = purchasePriceTextField.text ?? pill.purchasePrice
                pill.notice = noticeTextField.text ?? pill.notice
                if let illName = selectedIllName { // Checking if a new type was selected
                                pill.illName = illName
                }
            }
            onUpdatePill?()
            navigationController?.pushViewController(MyPillsViewController(), animated: true)
        } catch {
            print("Error updating pill: \(error)")
        }
        
    }
    private func showAlert(){
        let alert = UIAlertController(title: "Error!", message: "Please fill all fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert,animated: true)
    }
    @objc func badTap(){
        print("badTapped")
        let preparatsVC = PreparatsViewController()
            preparatsVC.modalPresentationStyle = .fullScreen
            preparatsVC.onSelection = { [weak self] selectedPillType in
                self?.selectedIllName = selectedPillType  // Store the selected type
            }
            self.present(preparatsVC, animated: true)
       
    }
}
