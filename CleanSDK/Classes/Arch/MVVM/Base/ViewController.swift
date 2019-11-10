//
//  ViewController.swift
//  CleanMVVM
//
//  Created by Artem Eremeev on 26/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import UIKit
import RxSwift

open class ViewController<VM: ViewModelType>: UIViewController, ViewType {
    
    public let disposeBag = DisposeBag()
    
    public typealias ViewModel = VM
    public var viewModel: ViewModel!
    
    public let willAppear = PublishSubject<Void>()
    public let didAppear = PublishSubject<Void>()
    public let willDisappear = PublishSubject<Void>()
    public let didDisappear = PublishSubject<Void>()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.bind(viewModel: self.viewModel)
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear.onNext(())
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear.onNext(())
    }
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisappear.onNext(())
    }
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappear.onNext(())
    }
    
    open func bind(viewModel: ViewModel) {
        
        viewModel.subscribeIfNeeded()
    }

}
