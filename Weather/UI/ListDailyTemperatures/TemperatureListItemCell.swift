//
//  TemperatureListItemCell.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit

final class TemperatureListItemCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: TemperatureListItemCell.self)

    lazy var maxTemperatureLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .light, fontSize: .extraLarge, color: .red)
        return label
    }()

    lazy var maxTemperatureDescriptionLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel()
        label.text = "max".localized()
        return label
    }()

    lazy var minTemperatureLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .light, fontSize: .extraLarge, color: .blue)
        return label
    }()

    lazy var minTemperatureDescriptionLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel()
        label.text = "min".localized()
        return label
    }()

    lazy var dayLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .larger)
        return label
    }()

    lazy var dateLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .medium, fontSize: .large)
        return label
    }()

    private func setupViews() {
        addSubview(maxTemperatureLabel)
        addSubview(maxTemperatureDescriptionLabel)
        addSubview(minTemperatureLabel)
        addSubview(minTemperatureDescriptionLabel)
        addSubview(dayLabel)
        addSubview(dateLabel)

        maxTemperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        maxTemperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        maxTemperatureDescriptionLabel.centerXAnchor.constraint(equalTo: maxTemperatureLabel.centerXAnchor).isActive = true
        maxTemperatureDescriptionLabel.topAnchor.constraint(equalTo: maxTemperatureLabel.bottomAnchor, constant: 5).isActive = true

        dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true

        dateLabel.centerXAnchor.constraint(equalTo: dayLabel.centerXAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 5).isActive = true

        minTemperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        minTemperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        minTemperatureDescriptionLabel.centerXAnchor.constraint(equalTo: minTemperatureLabel.centerXAnchor).isActive = true
        minTemperatureDescriptionLabel.topAnchor.constraint(equalTo: minTemperatureLabel.bottomAnchor, constant: 5).isActive = true

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: DailyTemperature) {
        maxTemperatureLabel.text = item.maximum
        dayLabel.text = item.dayOfWeek()
        dateLabel.text = item.dayOfMonth()
        minTemperatureLabel.text = item.minimum
    }
}
