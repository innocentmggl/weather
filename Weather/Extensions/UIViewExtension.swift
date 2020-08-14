//
//  UIViewExtension.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

extension UIView {

    @discardableResult
    func constrain(to: UIView) -> UIView {
        self.topAnchor.constraint(equalTo: to.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
        return self
    }

    @discardableResult
    func centerX(toView: UIView) -> UIView {
        self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
    func centerY(toView: UIView) -> UIView {
        self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    func leading(toView: UIView, constant: CGFloat = 0) -> UIView {
        self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func trailing(toView: UIView, constant: CGFloat = 0) -> UIView {
        self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func top(toView: UIView, constant: CGFloat = 0) -> UIView {
        self.topAnchor.constraint(equalTo: toView.topAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func topToBottom(ofView: UIView, constant: CGFloat = 0) -> UIView {
        self.topAnchor.constraint(equalTo: ofView.bottomAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func width(_ constant: CGFloat = 0) -> UIView {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    func height(_ constant: CGFloat = 0) -> UIView {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
}
