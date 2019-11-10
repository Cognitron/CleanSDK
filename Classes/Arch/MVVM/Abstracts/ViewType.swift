//
//  ViewType.swift
//  Clean
//
//  Created by Artem Eremeev on 26/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewType where Self.ViewModel: ViewModelType {
    associatedtype ViewModel
    func bind(viewModel: ViewModel)
}

public extension ViewType where Self: UIViewController {
    static var controllerIdentifier: String {
        return String(describing: self)
    }
}

public extension ViewType where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

public extension ViewType where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
