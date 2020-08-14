//
//  ViewWeatherDetailsViewController.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/11.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
import SDWebImage

class ViewWeatherDetailsViewController: UIViewController {

    private let viewModel: ViewWeatherDetailsViewModel
    private let scrollView = ViewWeatherComponents.shared.scrollView
    private let contentView = ViewWeatherComponents.shared.contentView
    private let cityLabel = ViewWeatherComponents.shared.cityLabel
    private let dateLabel = ViewWeatherComponents.shared.dateLabel
    private let conditionAvatar = ViewWeatherComponents.shared.conditionAvatar
    private let descriptionLabel = ViewWeatherComponents.shared.descriptionLabel
    private let currentTempLabel = ViewWeatherComponents.shared.currentTempLabel
    private let detailsLabel = ViewWeatherComponents.shared.detailsLabel

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: ViewWeatherDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1)
        self.title = "weather".localized()
        setupViews()
        setupData()
    }

    private func setupViews() {
        addSubviews()
        addConstrainsToViews()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(DetailsListItemCell.self, forCellWithReuseIdentifier: DetailsListItemCell.reuseIdentifier)
    }

    private func addSubviews() {
        view.addSubview(cityLabel)
        view.addSubview(dateLabel)
        view.addSubview(collectionView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(conditionAvatar)
        contentView.addSubview(currentTempLabel)
        contentView.addSubview(detailsLabel)
    }

    private func addConstrainsToViews() {
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        cityLabel.leading(toView: view).trailing(toView: view)

        dateLabel.topToBottom(ofView: cityLabel, constant: 12).leading(toView: view, constant: 16).trailing(toView: view, constant: 16)
        collectionView.topToBottom(ofView: dateLabel, constant: 12).leading(toView: view, constant: 16).trailing(toView: view, constant: -16).height(120)
        scrollView.topToBottom(ofView: collectionView, constant: 12).leading(toView: view).trailing(toView: view)
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.constrain(to: scrollView).width(self.view.frame.width)
        conditionAvatar.top(toView: contentView, constant: 4).centerX(toView: contentView).width(150).height(150)
        descriptionLabel.topToBottom(ofView: conditionAvatar, constant: 12).centerX(toView: contentView)
        currentTempLabel.topToBottom(ofView: descriptionLabel, constant: 12).centerX(toView: contentView)
        detailsLabel.topToBottom(ofView: currentTempLabel, constant: 16).leading(toView: contentView, constant: 16).trailing(toView: contentView, constant: -16)
    }

    private func setupData() {
        cityLabel.text = "\(viewModel.city.name), \(viewModel.city.country)"
        viewModel.day.bind { [unowned self] in
            self.dateLabel.text = $0
        }
        viewModel.selectedItem.bind { [unowned self] details in
            self.descriptionLabel.text = details.description.first?.heading
            self.currentTempLabel.text = "\(Int(details.forecast.maximum))\u{00B0}"
            self.conditionAvatar.sd_setImage(with: details.imageUrl())
            let details = "Wind Speed: \(details.wind.speed)\n\nWind Direction: \(details.wind.direction) deg\n\nHumidity: \(details.forecast.humidity)%"
            self.detailsLabel.text = details
        }
    }
}
// MARK: - COLLECTION VIEW FLOW LAYOUT DELEGATE
extension ViewWeatherDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 120)
    }
}

// MARK: - COLLECTION VIEW  DELEGATE
extension ViewWeatherDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectedItem(at: indexPath.row)
    }
}
// MARK: - COLLECTION VIEW DATASOURCE
extension ViewWeatherDetailsViewController: UICollectionViewDataSource {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable all
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsListItemCell.reuseIdentifier, for: indexPath) as? DetailsListItemCell else {
            fatalError("Cannot dequeue reusable cell \(DetailsListItemCell.self) with reuseIdentifier: \(DetailsListItemCell.reuseIdentifier)")
        }
        // swiftlint:enable all
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
}
