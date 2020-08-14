//
//  Alertable.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
/**
    Protocol that provides methods for managing the showing of dialog in a view controller
*/

public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    /**
     Presents a dialog modally.
     - Parameters:
        - title: Pass your alert title  in String.
        - message: Pass your alert message in String.
        - preferredStyle: Pass your prefered alert style in UIAlertController.Style.
        - completion: This will give you call back inside block when OK button is clicked

     ### Usage Example: ###
     ````
     self.showAlert(title:"Dialog title", andMessage: "Dialog message", preferredStyle: .alert) { (okClick) in
     }
     ````
     */
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
