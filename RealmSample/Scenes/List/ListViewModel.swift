//
//  ListViewModel.swift
//  RealmSample
//
//  Created by Berkay Sancar on 23.01.2023.
//

import Foundation

// MARK: - ListViewModel Outputs
protocol ListViewModelOutputs: AnyObject {
    func configureUI()
    func refreshTableView()
    func onError(message: String)
}

// MARK: - ListViewModel Inputs
protocol ListViewModelInputs {
    var addedList: [RealmModel]? { get }
    
    func viewDidLoad()
    func getAddedList()
    func deleteItem(index: Int)
    func updateItem(index: Int)
}

// MARK: - ListViewModel
final class ListViewModel {
    
    private weak var delegate: ListViewModelOutputs?
    private let realmManager: RealmManagerProtocol
    
    private(set) internal var addedList: [RealmModel]?
    
    init(delegate: ListViewModelOutputs, realmManager: RealmManagerProtocol = RealmManager.shared) {
        self.delegate = delegate
        self.realmManager = realmManager
    }
}

// MARK: - ListViewModelInputs
extension ListViewModel: ListViewModelInputs {
    
    func viewDidLoad() {
        delegate?.configureUI()
        getAddedList()
    }
    
    func getAddedList() {
        self.addedList = realmManager.getAll(RealmModel.self)
    }
    
    func deleteItem(index: Int) {
        guard let item = addedList?[index] else { return }
        self.realmManager.delete(item) { [weak self] (error) in
            guard let self else { return }
            self.delegate?.onError(message: "Something went wrong.")
        }
        self.addedList?.remove(at: index)
        self.delegate?.refreshTableView()
    }
    
    func updateItem(index: Int) {
        guard let item = addedList?[index] else { return }
        let dict = ["title": "Something"]
        self.realmManager.update(item, with: dict) { [weak self] (error) in
            self?.delegate?.onError(message: "Something went wrong.")
        }
        self.delegate?.refreshTableView()
    }
}
