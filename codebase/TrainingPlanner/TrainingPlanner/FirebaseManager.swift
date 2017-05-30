//
//  FirebaseManager.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-22.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FirebaseManager: NSObject {
    
    // MARK: Shared Instance
    
    static let sharedFirebase = FirebaseManager()
    private var databaseManager:DatabaseReference! = Database.database().reference()
    
}
