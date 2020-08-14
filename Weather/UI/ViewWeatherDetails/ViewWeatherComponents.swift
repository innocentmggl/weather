//
//  ViewWeatherComponents.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

class ViewWeatherComponents {

    static let shared = ViewWeatherComponents()

    private init() {}

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()

    lazy var cityLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .medium, fontSize: .large)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()

    lazy var dateLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .medium)
        label.backgroundColor = .clear
        return label
    }()

    lazy var conditionAvatar: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var descriptionLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .large)
        label.textAlignment = .center
        return label
    }()

    lazy var currentTempLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .extraLarge)
        label.textAlignment = .center
        return label
    }()

    lazy var detailsLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .medium)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
}
