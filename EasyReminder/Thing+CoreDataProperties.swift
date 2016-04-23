//
//  Thing+CoreDataProperties.swift
//  EasyReminder
//
//  Created by Yaxin Yuan on 16/4/23.
//  Copyright © 2016年 Yaxin Yuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Thing {

    @NSManaged var title: String?
    @NSManaged var content: String?
    @NSManaged var date: NSDate

}
