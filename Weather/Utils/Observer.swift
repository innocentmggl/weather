//
//  Observer.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
/// Simple class that handle  binding of view model properties in view controller and notifying listeners when property value is updated
public final class Observer<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    public var value: T {
        didSet { listener?(value) }
    }
    public init(_ value: T) {
        self.value = value
    }
    /**
     Bind lister to propery value, this eleminate the need to create delegation to update ui componets
     - Parameters:
     - lister: `Listener` typealias
     */
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
