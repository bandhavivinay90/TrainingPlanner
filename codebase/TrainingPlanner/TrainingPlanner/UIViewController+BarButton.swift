//
//  UINavigationController+BarButton.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-06-14.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

extension UIViewController{
    
    func addLogoutButton()->UIBarButtonItem{
        let button = UIButton.init(type: .custom)
        
        button.addTarget(self, action:#selector(self.logOut), for: UIControlEvents.touchUpInside)
        
        button.setImage(UIImage.init(named: "logout.png"), for: UIControlState.normal)
        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        let barButton = UIBarButtonItem.init(customView: button)
        return barButton
    }
    
    func logOut(){
        UserRequest.init().signOut(
            {
                self.dismiss(animated: true, completion: {
                    self.clearSavedToken()
                })
        },
            failure:
            {
                (error : Error?) in
        })
    }
    
    func clearSavedToken(){
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
    }
    
}
