//
//  Item+CoreDataClass.swift
//  DataCoreTutorial
//
//  Created by Khoa on 10/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
    
    
    
    
}
