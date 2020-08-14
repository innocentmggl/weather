//
//  LabelBuilder.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

class LabelBuilder: UILabel {

    func buildCustomLabel(fontFace: FontFace = .book, fontSize: FontSize = .normal, color: UIColor = .darkGray) -> LabelBuilder {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.customFont(fontFace: fontFace, size: fontSize)
        self.textColor = color
        return self
    }

}
