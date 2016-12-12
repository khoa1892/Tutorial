//
//  TableViewCell.swift
//  CollectionTableView
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

}

extension TableViewCell {
    func setCollectionView(D delegate: (UICollectionViewDataSource & UICollectionViewDelegate), forRow row: Int) {
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        self.collectionView.tag = row
        self.collectionView.reloadData()
    }
}
