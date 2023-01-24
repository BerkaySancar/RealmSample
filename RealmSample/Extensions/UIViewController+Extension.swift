//
//  UIViewController+Extension.swift
//  RealmSample
//
//  Created by Berkay Sancar on 24.01.2023.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
