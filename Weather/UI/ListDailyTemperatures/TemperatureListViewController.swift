//
//  TemperatureListViewController.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
import CoreLocation

class TemperatureListViewController: UIViewController, Alertable, LoadingIndicator {
    var loadingView: UIView?
    private let viewModel: TemperatureListViewModel = AppDIContainer.shared.temperatureListViewModel
    private var locationManager: CLLocationManager?
    private let infoView = InformationView()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var cityLabel: LabelBuilder = {
        let label = LabelBuilder().buildCustomLabel(fontFace: .book, fontSize: .large)
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }

    // MARK: - VIEW CONTROLLER LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        bind(to: viewModel)
        setupLocationManager()
    }

    // MARK: - HELPER METHODS
    private func setupViews() {
        self.view.backgroundColor = UIColor(red: 239/255, green: 240/255, blue: 241/255, alpha: 1)
        self.title = "forecast".localized()
        self.view.addSubview(cityLabel)
        cityLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    func setupCollectionView() {
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(TemperatureListItemCell.self, forCellWithReuseIdentifier: TemperatureListItemCell.reuseIdentifier)

        collectionView.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 12).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    func setupLocationManager() {
         locationManager = CLLocationManager()
         locationManager?.delegate = self
         locationManager?.requestAlwaysAuthorization()
         startLocationUpdates()
     }

    @objc func startLocationUpdates() {
        infoView.hideInfoView()
        locationManager?.startUpdatingLocation()
    }

    func handleRoute(route: Router) {
        switch route {
        case .none: break
        case .showDetails(let viewModel):
            let detailVC = ViewWeatherDetailsViewController(viewModel: viewModel)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    ///binds view model property
    private func bind(to viewModel: TemperatureListViewModel) {
        viewModel.city.bind { [unowned self] in
            self.cityLabel.text = $0
        }
        viewModel.items.bind { [unowned self] _ in
            self.collectionView.reloadData()
        }
        viewModel.error.bind { [unowned self] in
            if !$0.isEmpty {
                self.infoView.showInfo(onView: self.view,
                                  title: "error.title".localized(),
                                  message: $0,
                                  target: self,
                                  action: #selector(self.startLocationUpdates))
            }
        }
        viewModel.loading.bind { [unowned self] loading in
            loading ? self.showSpinner(onView: self.view) : self.hideSpinner()
        }
        viewModel.message.bind { [unowned self]  in
            if !$0.isEmpty {
                self.showAlert(title: "server.resoinse".localized(), message: $0)
            }
        }
        viewModel.route.bind { [unowned self] route in
            self.handleRoute(route: route)
        }
    }
}

// MARK: - COLLECTION VIEW FLOW LAYOUT DELEGATE
extension TemperatureListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    // swiftlint:disable all
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    // swiftlint:enable all
}

// MARK: - COLLECTION VIEW  DELEGATE
extension TemperatureListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectedItem(at: indexPath.row)
    }
}
// MARK: - COLLECTION VIEW DATASOURCE
extension TemperatureListViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable all
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemperatureListItemCell.reuseIdentifier, for: indexPath) as? TemperatureListItemCell else {
            fatalError("Cannot dequeue reusable cell \(TemperatureListItemCell.self) with reuseIdentifier: \(TemperatureListItemCell.reuseIdentifier)")
        }
        // swiftlint:enable all
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
}
// MARK: - LOCATION MANAGER DELEGATE
extension TemperatureListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            viewModel.getDailyTemperaturesFor(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            locationManager?.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            if viewModel.items.value.count == 0 {
                infoView.showInfo(onView: self.view,
                                  title: "error.location".localized(),
                                  message: "location.permision.required".localized(),
                                  target: self,
                                  action: #selector(doNothing))
            }

        default:
            infoView.hideInfoView()
        }
    }

    @objc func doNothing() {}
}
