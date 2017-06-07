//
//  Utility.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-07.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func returnDeviceFrame() -> CGRect{
        let screenSize: CGRect = UIScreen.main.bounds
        return screenSize
    }
}
