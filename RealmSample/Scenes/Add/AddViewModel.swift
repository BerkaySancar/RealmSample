//
//  AddViewModel.swift
//  RealmSample
//
//  Created by Berkay Sancar on 23.01.2023.
//

import Foundation

// MARK: - AddViewModelOutputs
protocol AddViewModelOutputs: AnyObject {
    func configureUI()
    func onError(message: String)
}

// MARK: - AddViewModelInputs
protocol AddViewModelInputs {
    func viewDidLoad()
    func addModel(title: String?)
}

// MARK: - AddViewModel
final class AddViewModel {
    
    private weak var delegate: AddViewModelOutputs?
    private let realmManager: RealmManagerProtocol
    
    init(delegate: AddViewModelOutputs, realmManager: RealmManagerProtocol = RealmManager.shared) {
        self.delegate = delegate
        self.realmManager = realmManager
    }
}

// MARK: - AddViewModelInputs
extension AddViewModel: AddViewModelInputs {
    
    func viewDidLoad() {
        delegate?.configureUI()
    }
    
    func addModel(title: String?) {
        if let title, !title.isEmpty, !isAdded(title: title) {
            //Add
            let model = RealmModel(title: title)
            self.realmManager.create(model) { [weak self] (error) in
                guard let self else { return }
                self.delegate?.onError(message: "Something went wrong.")
            }
        } else {
            //ShowAlert
            self.delegate?.onError(message: "Cannot be empty & Already added.")
        }
    }
}

// MARK: - Private Functions
extension AddViewModel {
    private func isAdded(title: String) -> Bool {
        if realmManager.getAll(RealmModel.self).filter({ $0.title == title }).isEmpty == true {
            return false
        } else {
            return true
        }
    }
}
