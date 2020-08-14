//
//  AppAppearance.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import  UIKit
/**
    Global app appearance configuration class
*/
final class AppAppearance {
    /**
     Setup global app navigation bar appearance
     */
    static func setupAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1)
        UINavigationBar.appearance().tintColor = .darkGray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.customFont(fontFace: .medium, size: .large),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray]
    }
}
