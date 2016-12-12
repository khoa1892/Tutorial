//
//  ViewController.swift
//  ReadEpub
//
//  Created by Khoa on 11/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import FolioReaderKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func openEBook(_ sender: Any) {
        self.open(bookName: "1")
    }
    
    @IBAction func openEbook1(_ sender: Any) {
        self.open(bookName: "iOS_7_Programming_Cookbook")
    }
    
    func open(bookName: String) {
        let config = FolioReaderConfig()
        config.scrollDirection = .horizontalWithVerticalContent
        config.shouldHideNavigationOnTap = false
        let bookPath = Bundle.main.path(forResource: bookName, ofType: "epub") ?? ""
        FolioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: config)
    }
    
}

