//
//  LoginNode.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 8.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import CoreData

class LoginNode: NSManagedObject {
    @NSManaged var children: NSSet?
    @NSManaged var parent: LoginNode?
    @NSManaged var idString: String

    @NSManaged var isLoggedIn: Bool
}

extension LoginNode {
    static func getNodes() -> NSFetchRequest<LoginNode> {
        let request = LoginNode.fetchRequest() as! NSFetchRequest<LoginNode>
        request.sortDescriptors = [NSSortDescriptor(key: "idString", ascending: true)]
        return request
    }
}
