//
//  AddViewController.swift
//  RealmSample
//
//  Created by Berkay Sancar on 23.01.2023.
//

import UIKit

final class AddViewController: UIViewController {
   
    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Add..."
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go to List", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goTapped), for: .touchUpInside)
        return button
    }()

    private lazy var viewModel: AddViewModelInputs = AddViewModel(delegate: self)

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        infoTextField.text = ""
    }
      
// MARK: - Actions
    @objc private func addTapped() {
        viewModel.addModel(title: infoTextField.text)
        self.navigationController?.pushViewController(ListViewController(), animated: true)
    }
    
    @objc private func goTapped() {
        self.navigationController?.pushViewController(ListViewController(), animated: true)
    }
}

// MARK: - AddViewModelOutputs
extension AddViewController: AddViewModelOutputs {
    
    func configureUI() {
        title = "Add"
        view.backgroundColor = .systemBackground
        view.addSubview(infoTextField)
        view.addSubview(addButton)
        view.addSubview(goButton)
        
        NSLayoutConstraint.activate([infoTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                                     infoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     infoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
        
        NSLayoutConstraint.activate([addButton.topAnchor.constraint(equalTo: infoTextField.bottomAnchor, constant: 20),
                                     addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        NSLayoutConstraint.activate([goButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 20),
                                     goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    func onError(message: String) {
        self.showAlert(message: message)
    }
}
