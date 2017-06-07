//
//  ViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-18.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var newUserRequestButton: UIButton!
    
    @IBOutlet weak var registrationView:UIView!
    @IBOutlet weak var loginView:UIView!
    @IBOutlet weak var containerView:UIView!
    
    @IBOutlet weak var loginViewHeightConstraint:NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
        //Set the height of login view in proportion to the device's height ...
       // loginViewHeightConstraint.constant = Utility.returnDeviceFrame().height * 0.5

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerNewUser(_ sender: AnyObject){
        emailTextField.text = "bandhavi.vinay2010@gmail.com"
        passwordTextField.text = "123456"
    }
    
    
    @IBAction func newUserRequestSelected(_ sender: AnyObject){
        
        UIView.transition(with: containerView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.registrationView.isHidden = false
            self.loginView.isHidden = true
            self.newUserRequestButton.isHidden = true
        }, completion: nil)

    }
    
    @IBAction func closeRegistrationSelected(_ sender: AnyObject){
        
        UIView.transition(with: containerView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
            self.registrationView.isHidden = true
            self.loginView.isHidden = false
            self.newUserRequestButton.isHidden = false
        }, completion: nil)
       
    }
    
    
    @IBAction func signIn(_ sender: AnyObject){
    
        emailTextField.text = "bandhavi.vinay@sogeti.se"
        passwordTextField.text = "123456"
        if(((emailTextField.text) != nil) && (passwordTextField.text != nil)){

            NetworkManager.sharedNetworkManager.makePostRequest("")
            
        }
        else{
            print("Details empty")
        }
        
    }
    
}

