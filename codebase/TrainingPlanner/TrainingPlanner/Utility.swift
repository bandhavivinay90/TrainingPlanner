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
    
    class func showAlertPopUp(inTitle:String, inMessage:String,presentingController:UIViewController){
        let alertView = UIAlertController(title: inTitle, message: inMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            
        })
        alertView.addAction(action)
        presentingController.present(alertView, animated: true, completion: nil)
    }
}

