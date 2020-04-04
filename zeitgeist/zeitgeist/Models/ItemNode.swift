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
    
    //    @NSManaged var brand: String
    @NSManaged var size: String
    //    @NSManaged var condition: String
    //    @NSManaged var price: String
    //    @NSManaged var description: String
}

extension ItemNode {
    static func getNodes() -> NSFetchRequest<ItemNode> {
        let request = ItemNode.fetchRequest() as! NSFetchRequest<ItemNode>
        request.sortDescriptors = [NSSortDescriptor(key: "idString", ascending: true)]
        //request.sortDescriptors = [NSSortDescriptor(key: "size", ascending: true)]
        return request
    }
}
