//
//  LoadingIndicator.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import UIKit
/**
 Protocol that provides methods for managing the showing of loading indicator in a view controller
 */

protocol LoadingIndicator: class {
    var loadingView: UIView? {get set}
}

extension LoadingIndicator where Self: UIViewController {
    /**
     Create loading indicator view.
     - Parameters:
     - frame: `CGRect` The parent view framw you want to present the loading indiicator on.
     - returns: `UIView` the newly created view instance
     */
    private func createSpinner(frame: CGRect) -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

        let loadingIndicator = self.createActivityIndicatorView()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        return view
    }

    /**
     Create UIActivityIndicatorView instance.
     - Parameters:
     - frame: `CGRect` The parent view framw you want to present the loading indiicator on.
     - returns: `UIActivityIndicatorView` the newly created loading indicator view
     */
    private func createActivityIndicatorView() -> UIActivityIndicatorView {
        var indicatorStyle: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            indicatorStyle = UIActivityIndicatorView.Style.large
        } else {
            indicatorStyle = UIActivityIndicatorView.Style.whiteLarge
        }
        let loadingIndicator = UIActivityIndicatorView.init(style: indicatorStyle)
        loadingIndicator.startAnimating()
        return loadingIndicator
    }

    /**
     Create and show loading indicator.
     - Parameters:
     - onView: `UIView` The view you want to present the loading indiicator on.
     */
    func showSpinner(onView: UIView) {
        DispatchQueue.main.async {
            if self.loadingView == nil {
                self.loadingView = self.createSpinner(frame: onView.bounds)
                onView.addSubview(self.loadingView!)
            }
        }
    }

    /// hides  loading indicator .
    func hideSpinner() {
        DispatchQueue.main.async {
            if self.loadingView != nil {
                self.loadingView?.removeFromSuperview()
                self.loadingView = nil
            }
        }
    }
}
