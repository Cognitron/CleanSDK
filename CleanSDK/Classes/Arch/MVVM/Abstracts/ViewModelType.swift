//
//  ViewModelType.swift
//  Clean
//
//  Created by Artem Eremeev on 26/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol ViewModelType {
    
    func subscribeIfNeeded()
    func subscribe()
    
    var isLoading: BehaviorRelay<Bool> { get }
    
}


