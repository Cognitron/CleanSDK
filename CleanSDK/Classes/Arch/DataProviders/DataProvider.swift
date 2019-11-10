//
//  DataProvider.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

open class DataProvider {
    
    public private(set) weak var loading: BehaviorRelay<Bool>?
    public private(set) weak var progress: BehaviorRelay<Float>?
    
    public init(loading: BehaviorRelay<Bool>! = nil, progress: BehaviorRelay<Float>! = nil) {
        self.loading = loading
        self.progress = progress
    }
    
    deinit {
        print("\(type(of: self)) released")
    }
    
}
