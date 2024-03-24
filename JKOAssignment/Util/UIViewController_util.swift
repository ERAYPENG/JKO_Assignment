//
//  UIViewController_util.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message : String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .gray
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            alert.dismiss(animated: true) {
                completion?()
            }
        }
    }
}
