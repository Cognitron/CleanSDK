//
//  TableViewCellProvider.swift
//  Clean
//
//  Created by Artem Eremeev on 28/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class CellConstructor {
    
    private unowned let tableView: UITableView!
    private unowned let collectionView: UICollectionView!
    
    private var registeredCells = Set<String>()
    
    public init(_ tableView: UITableView) {
        self.tableView = tableView
        self.collectionView = nil
    }
    
    public init(_ collectionView: UICollectionView) {
        self.tableView = nil
        self.collectionView = collectionView
    }
    
    public func cell(using block: CellBlockType, indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = self.collectionView else {
            fatalError("Для запроса CollectionViewCell требуется UICollectionView")
        }
        if !registeredCells.contains(block.cellIdentifier) {
            collectionView.register(UINib(nibName: block.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: block.cellIdentifier)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: block.cellIdentifier, for: indexPath) as! CellType
        cell.set(viewModel: block.cellViewModel)
        return cell as! UICollectionViewCell
    }
    
    public func cell(using block: CellBlockType, indexPath: IndexPath) -> UITableViewCell {
        guard let tableView = self.tableView else {
            fatalError("Для запроса TableViewCell требуется UITableView")
        }
        if !registeredCells.contains(block.cellIdentifier) {
            tableView.register(UINib(nibName: block.cellIdentifier, bundle: nil), forCellReuseIdentifier: block.cellIdentifier)
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: block.cellIdentifier, for: indexPath) as! CellType
        cell.set(viewModel: block.cellViewModel)
        return cell as! UITableViewCell
    }
    
    public func cell<VM, C: TableViewCell<VM>>(_ cellType: C.Type, viewModel: VM, indexPath: IndexPath! = nil) -> UITableViewCell {
        guard let tableView = self.tableView else {
            fatalError("Для запроса TableViewCell требуется UITableView")
        }
        if !registeredCells.contains(C.cellIdentifier) {
            tableView.register(UINib(nibName: C.cellIdentifier, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        }
        let cell: C = {
            if let indexPath = indexPath {
                return tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! C
            } else {
                return tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier) as! C
            }
        }()
        cell.bind(viewModel: viewModel)
        return cell
    }
    
    public func cell<VM, C: CollectionViewCell<VM>>(_ cellType: C.Type, viewModel: VM, indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = self.collectionView else {
            fatalError("Для запроса CollectionViewCell требуется UICollectionView")
        }
        if !registeredCells.contains(C.cellIdentifier) {
            collectionView.register(UINib(nibName: C.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: C.cellIdentifier)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.cellIdentifier, for: indexPath) as! C
        cell.bind(viewModel: viewModel)
        return cell
    }
    
}
