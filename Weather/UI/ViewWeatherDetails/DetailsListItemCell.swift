//
//  DetailsListItemCell.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
import SDWebImage

final class DetailsListItemCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DetailsListItemCell.self)

    lazy var timeLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .medium, fontSize: .medium)
        return label
    }()

    lazy var avatar: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var temperatureLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .medium, fontSize: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(timeLabel)
        addSubview(avatar)
        addSubview(temperatureLabel)

        timeLabel.top(toView: self, constant: 4).centerX(toView: self)
        avatar.topToBottom(ofView: timeLabel, constant: 4).centerX(toView: self).width(70).height(70)
        temperatureLabel.topToBottom(ofView: avatar, constant: 4).centerX(toView: self)
    }
    /**
     Configure cell with data.
     - Parameters:
        - item: The weather item to show.
     */
    func configure(with item: Weather) {
        self.timeLabel.text = item.time()
        self.avatar.sd_setImage(with: item.imageUrl())
        self.temperatureLabel.text = "\(Int(item.forecast.maximum))\u{00B0}"
    }
}
