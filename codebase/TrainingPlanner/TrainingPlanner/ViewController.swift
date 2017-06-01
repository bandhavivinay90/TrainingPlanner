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
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
//        Auth.auth().createUser(withEmail: "bandhavi.vinay@sogeti.se", password: "123456") { (user, error) in
//            print(user)
//            print(error)
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(_ sender: AnyObject){
    
        emailTextField.text = "bandhavi.vinay@sogeti.se"
        passwordTextField.text = "123456"
        if(((emailTextField.text) != nil) && (passwordTextField.text != nil)){
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                //            user?.sendEmailVerification(completion: { (error) in
                //                print(error)
                //            })
                //            print(user?.isEmailVerified)
//                let changeRequest = user?.createProfileChangeRequest()
//                changeRequest?.displayName = "Bandhavi Vinay"
//                changeRequest?.commitChanges(completion: { (error) in
//                    print(error)
//                    print(user)
//                    
//                })
                if(user != nil){
                    //User returned successfully ...
                    self.performSegue(withIdentifier: "signInSegue", sender: sender)
                }
                else{
                    print(error?.localizedDescription)
                }
            }
            
         //   NetworkManager.sharedNetworkManager.makePostRequest("")
            
            
        }
        else{
            print("Details empty")
        }
        
    }
    



}

