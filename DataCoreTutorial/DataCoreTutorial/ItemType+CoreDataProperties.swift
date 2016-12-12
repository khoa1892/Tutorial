//
//  ItemType+CoreDataProperties.swift
//  DataCoreTutorial
//
//  Created by Khoa on 10/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
