//
//  String+Validation.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-08.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import Foundation

extension String{
    
    func validateEmail(inString: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: inString)
    }
    
}
