//
//  InformationView.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

class InformationView {

    private var infoView: UIView?
    private let titleLabel = LabelBuilder().buildCustomLabel(fontFace: .medium, fontSize: .large)
    private let messageLabel = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .medium)
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("retry".localized(), for: .normal)
        button.setTitleColor( .blue, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /**
     Create loading indicator view.
     - Parameters:
     - frame: `CGRect` The parent view framw you want to present the loading indiicator on.
     - returns: `UIView` the newly created view instance
     */
    private func createInfoView(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(retryButton)

        titleLabel.centerX(toView: view).centerY(toView: view)
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()
        messageLabel.textAlignment = .center
        messageLabel.topToBottom(ofView: titleLabel, constant: 14).leading(toView: view, constant: 16).trailing(toView: view, constant: -16)
        retryButton.topToBottom(ofView: messageLabel, constant: 20).centerX(toView: view)

        return view
    }

    /**
     Create and show loading indicator.
     - Parameters:
     - onView: `UIView` The view you want to present the loading indiicator on.
     */
    func showInfo(onView: UIView, title: String, message: String, target: Any?, action: Selector) {
        DispatchQueue.main.async {
            if self.infoView == nil {
                self.infoView = self.createInfoView(frame: onView.bounds)
                onView.addSubview(self.infoView!)
            }
            self.titleLabel.text = title
            self.messageLabel.text = message
            self.retryButton.removeTarget(target, action: nil, for: .touchUpInside)
            self.retryButton.addTarget(target, action: action, for: .touchUpInside)
        }
    }

    /// hides  loading indicator .
    func hideInfoView() {
        DispatchQueue.main.async {
            if self.infoView != nil {
                self.infoView?.removeFromSuperview()
                self.infoView = nil
            }
        }
    }
}
