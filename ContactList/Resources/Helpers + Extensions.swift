//
//  Helpers + Extensions.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentsSimpleAlertWith(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
