//
//  ViewController.swift
//  CollectionTableView
//
//  Created by Khoa on 11/17/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrImage:[[String]] = [["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"], ["1", "2", "3"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrImage.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.setCollectionView(D: self as (UICollectionViewDataSource & UICollectionViewDelegate), forRow: indexPath.row)
        return cell
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrImage[collectionView.tag].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: self.arrImage[collectionView.tag][indexPath.row])
        return cell
    }
}

