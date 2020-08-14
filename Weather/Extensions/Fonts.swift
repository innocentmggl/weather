//
//  Fonts.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

// MARK: - UIFont Helpers
extension UIFont {
    /**
     Creates and return custom font.
     - Parameters:
        - fontFace: The custom font family string `enum`.
        - size: The custom font size CGFloat `enum`.
        - Returns: custom `IUFont` if `FontFace` value exist else return system font.
     */
    static func customFont(fontFace: FontFace, size: FontSize) -> UIFont {
        let font = UIFont(name: fontFace.rawValue, size: size.rawValue)
        assert(font != nil, "Can't load font: \(fontFace.rawValue)")
        return font ?? UIFont.systemFont(ofSize: size.rawValue)
    }
}

///Font face values
enum FontFace: String {
  case bold = "Gotham-Bold"
  case book = "Gotham-Book"
  case medium = "Gotham-Medium"
  case light = "Gotham-Light"
}
///Font sizes values
enum FontSize: CGFloat {
    case small = 10
    case normal = 12
    case medium = 14
    case large = 20
    case larger = 25
    case extraLarge = 34
    case xxLarge = 60
}
