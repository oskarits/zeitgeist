//
//  File.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 17.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import CoreData

class CheckoutNode: NSManagedObject {
    
    @NSManaged var idString: String
    @NSManaged var children: NSSet?
    @NSManaged var parent: CheckoutNode?
    
    @NSManaged var brand: String
    @NSManaged var size: String
    @NSManaged var price: String

    @NSManaged var order: Int
    @NSManaged var isReserved: Bool
    @NSManaged var isCollected: Bool
}

extension CheckoutNode {
    static func getNodes() -> NSFetchRequest<CheckoutNode> {
        let request = CheckoutNode.fetchRequest() as! NSFetchRequest<CheckoutNode>
        request.sortDescriptors = [NSSortDescriptor(key: "idString", ascending: true)]
        return request
    }
}
