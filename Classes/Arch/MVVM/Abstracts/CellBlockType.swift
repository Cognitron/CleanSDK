//
//  CellBlockType.swift
//  CleanMVVM
//
//  Created by Artem Eremeev on 29/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public protocol CellBlockType {
    var cellIdentifier: String { get }
    var cellViewModel: ViewModelType { get }
}
