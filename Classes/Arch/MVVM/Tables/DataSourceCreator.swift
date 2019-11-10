//
//  DataSourceCreator.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxDataSources

public class DataSourceCreator {
    
    // TableView
    
    public static func reloadTableViewDataSource<VM, C: TableViewCell<VM>>(_ cellType: C.Type) -> RxTableViewSectionedReloadDataSource<SectionModel<String, VM>> {
        return RxTableViewSectionedReloadDataSource(configureCell: { _, tableView, indexPath, viewModel in
            return CellConstructor(tableView).cell(cellType, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func reloadTableViewDataSource<B: CellBlockType>(_ blockType: B.Type) -> RxTableViewSectionedReloadDataSource<SectionModel<String, B>> {
        return RxTableViewSectionedReloadDataSource(configureCell: { _, tableView, indexPath, block in
            return CellConstructor(tableView).cell(using: block, indexPath: indexPath)
        })
    }
    
    public static func animatedTableViewDataSource<VM: IdentifiableType, C: TableViewCell<VM>>(_ cellType: C.Type) -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, VM>> {
        return RxTableViewSectionedAnimatedDataSource(configureCell: { _, tableView, indexPath, viewModel in
            return CellConstructor(tableView).cell(cellType, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func animatedTableViewDataSource<B: CellBlockType & IdentifiableType>(_ blockType: B.Type) -> RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String, B>> {
        return RxTableViewSectionedAnimatedDataSource(configureCell: { _, tableView, indexPath, block in
            return CellConstructor(tableView).cell(using: block, indexPath: indexPath)
        })
    }
    
    // CollectionView
    
    public static func reloadCollectionViewDataSource<VM, C: CollectionViewCell<VM>>(_ cellType: C.Type) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, VM>> {
        return RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, viewModel in
            return CellConstructor(collectionView).cell(cellType, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func reloadCollectionViewDataSource<B: CellBlockType>(_ blockType: B.Type) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, B>> {
        return RxCollectionViewSectionedReloadDataSource(configureCell: { _, collectionView, indexPath, block in
            return CellConstructor(collectionView).cell(using: block, indexPath: indexPath)
        })
    }
    
    public static func animatedCollectionViewDataSource<VM: IdentifiableType, C: CollectionViewCell<VM>>(_ cellType: C.Type) -> RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, VM>> {
        return RxCollectionViewSectionedAnimatedDataSource(configureCell: { _, collectionView, indexPath, viewModel in
            return CellConstructor(collectionView).cell(cellType, viewModel: viewModel, indexPath: indexPath)
        })
    }
    
    public static func animatedCollectionViewDataSource<B: CellBlockType>(_ blockType: B.Type) -> RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<String, B>> {
        return RxCollectionViewSectionedAnimatedDataSource(configureCell: { _, collectionView, indexPath, block in
            return CellConstructor(collectionView).cell(using: block, indexPath: indexPath)
        })
    }
    
}
