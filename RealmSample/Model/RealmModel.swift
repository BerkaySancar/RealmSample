//
//  RealmModel.swift
//  RealmSample
//
//  Created by Berkay Sancar on 23.01.2023.
//

import Foundation
import RealmSwift

class RealmModel: Object {
    @Persisted var title: String
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
