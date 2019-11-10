//
//  CollectionViewCell.swift
//  Clean
//
//  Created by Artem Eremeev on 26/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import UIKit
import RxSwift

open class CollectionViewCell<ViewModel: ViewModelType>: UICollectionViewCell, CellType, ViewType {
    public let disposeBag = DisposeBag()
    public private(set) var reusableDisposeBag = DisposeBag()
    
    public typealias ViewModel = ViewModel

    open func bind(viewModel: ViewModel) {
        viewModel.subscribeIfNeeded()
    }
    
    public func set(viewModel: ViewModelType) {
        guard let viewModel = viewModel as? ViewModel else {
            fatalError("Не удается преобразовать ViewModelType в \(String(describing: ViewModel.self))")
        }
        self.bind(viewModel: viewModel)
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        reusableDisposeBag = DisposeBag()
    }
    
}
