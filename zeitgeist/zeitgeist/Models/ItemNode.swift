//
//  ItemNode.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 4.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import CoreData

class ItemNode: NSManagedObject {
    
    @NSManaged var idString: String
    @NSManaged var children: NSSet?
    @NSManaged var parent: ItemNode?
}

extension ItemNode {
    static func getNodes() -> NSFetchRequest<ItemNode> {
        let request = ItemNode.fetchRequest() as! NSFetchRequest<ItemNode>
        request.sortDescriptors = [NSSortDescriptor(key: "idString", ascending: true)]
        return request
    }
}
