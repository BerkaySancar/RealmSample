//
//  RealmManager.swift
//  RealmSample
//
//  Created by Berkay Sancar on 23.01.2023.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func create<T: Object>(_ object: T, onError: (Error) -> ())
    func getAll<T: Object>(_ object: T.Type) -> [T]
    func update<T: Object>(_ object: T, with dictionary: [String: Any?], onError: (Error) -> ())
    func delete<T: Object>(_ object: T, onError: (Error) -> ())
}

final class RealmManager: RealmManagerProtocol {
    
    static let shared = RealmManager()
    private let realm = try! Realm()
    private init() {}

    func create<T: Object>(_ object: T, onError: (Error) -> ()) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
//            print("Error creating object: \(error)")
            onError(error)
        }
    }
    
    func getAll<T: Object>(_ object: T.Type) -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?], onError: (Error) -> ()) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
//            print("Error updating object: \(error)")
            onError(error)
        }
    }

    func delete<T: Object>(_ object: T, onError: (Error) -> ()) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            onError(error)
        }
    }
}
