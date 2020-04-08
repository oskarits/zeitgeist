//
//  LoginNode.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 8.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import CoreData

class LoginNode: NSManagedObject {
    
    
    @NSManaged var isLoggedIn: Bool
    //    @NSManaged var condition: String
    //    @NSManaged var description: String
}

extension LoginNode {
    static func getNodes() -> NSFetchRequest<LoginNode> {
        let request = LoginNode.fetchRequest() as! NSFetchRequest<LoginNode>
        request.sortDescriptors = [NSSortDescriptor(key: "isLoggedIn", ascending: true)]
        return request
    }
}
