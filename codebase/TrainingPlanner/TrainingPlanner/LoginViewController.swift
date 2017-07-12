//
//  ViewController.swift
//  TrainingPlanner
//
//  Created by Bandhavi on 2017-05-18.
//  Copyright © 2017 Sogeti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userDescriptionTextField: UITextField!
    @IBOutlet weak var useremailIDTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var newUserRequestButton: UIButton!
    
    @IBOutlet weak var loginScrollView:UIScrollView!
    @IBOutlet weak var registrationView:UIView!
    @IBOutlet weak var loginView:UIView!
    @IBOutlet weak var containerView:UIView!
    
    var isLandscapeOrientation:Bool?
    
    var loginViewModel:LoginViewModel?
    var tempContainerViewContraintValue:CGFloat?
    
    @IBOutlet weak var containerViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var loginViewHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var containerViewAlignmentConstraint:NSLayoutConstraint!
    
    var isRegistrationScreen:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        if let data = String(describing: tempTraining).data(using: .utf8) {
//            do {
//                let test:[String:Any] =  try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                print(test)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }

        
        
        setInitialState()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        isLandscapeOrientation = UIDevice.current.orientation.isLandscape
        setProgrammableConstraints()
    }
    
    
    func setInitialState(){
        
        isLandscapeOrientation = UIDevice.current.orientation.isLandscape
        
        let textFieldTransformFactor:CATransform3D = CATransform3DMakeTranslation(CGFloat(Constants.Login.textFieldOffset), 0, 0)
        
        emailTextField.layer.sublayerTransform = textFieldTransformFactor
        passwordTextField.layer.sublayerTransform = textFieldTransformFactor
        userPasswordTextField.layer.sublayerTransform = textFieldTransformFactor
        useremailIDTextField.layer.sublayerTransform = textFieldTransformFactor
        userDescriptionTextField.layer.sublayerTransform = textFieldTransformFactor
        userNameTextField.layer.sublayerTransform = textFieldTransformFactor
        setProgrammableConstraints()
        
        var contentRect = CGRect.zero
        for view in loginScrollView.subviews {
            contentRect = contentRect.union(view.frame)
        }
        loginScrollView.contentSize = contentRect.size
        
    }
    
    
    func setProgrammableConstraints(){
        
        //Set the height of login view in proportion to the device's height ...
        let desiredWidth = Utility.returnDeviceFrame().width * 0.9
        let desiredHeight = Utility.returnDeviceFrame().height * 0.6
        
        containerViewWidthConstraint.constant = (desiredWidth <= 360) ? desiredWidth : 360
        containerViewHeightConstraint.constant = (desiredHeight >= 500) ? 500 : desiredHeight
        
        let loginViewDesiredHeight = containerViewHeightConstraint.constant * 0.65
        loginViewHeightConstraint.constant = (loginViewDesiredHeight <= 190) ? 190 : loginViewDesiredHeight
        
        containerViewHeightConstraint.constant = 400
        
        if let tempValue = tempContainerViewContraintValue{
            containerViewAlignmentConstraint.constant = tempValue
        }
        
        updateContainerViewConstraints()
        
    }
    
    //MARK: Button Action Handlers
    
    @IBAction func newUserRequestSelected(_ sender: AnyObject){
        
        isRegistrationScreen = true
        setProgrammableConstraints()
        
        UIView.transition(with: containerView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromRight, animations: {
            self.registrationView.isHidden = false
            self.loginView.isHidden = true
            self.newUserRequestButton.isHidden = true
        }, completion: nil)
        
    }
    
    @IBAction func closeRegistrationSelected(_ sender: AnyObject){
        
        isRegistrationScreen = false
        setProgrammableConstraints()
        UIView.transition(with: containerView, duration: 1.0, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
            self.registrationView.isHidden = true
            self.loginView.isHidden = false
            self.newUserRequestButton.isHidden = false
        }, completion: nil)
        
    }
    
    @IBAction func signIn(_ sender: AnyObject){
        
                emailTextField.text = "bandhavi.vinay2010@gmail.com"
                passwordTextField.text = "123456"
                if(((emailTextField.text) != nil) && (passwordTextField.text != nil)){
        
                    loginViewModel = LoginViewModel(inEmailId: emailTextField.text!,inPassword: passwordTextField.text!,responseCallback: {(inUser:User) in
        
                        print(inUser)
                        if (inUser.emailAddress == self.emailTextField.text){
                            //Proceed to the home screen ...
                            print("Printing user's description - \(String(describing: inUser.userDescription))")
                            self.performSegue(withIdentifier: "signInSegue", sender: sender)
                        }
                        else{
                            Utility.showAlertPopUp(inTitle: "Error", inMessage: "Login Error", presentingController: self)
                        }
        
                    })

                }
                else{
                    print("Details empty")
                    Utility.showAlertPopUp(inTitle: "Missing Fields", inMessage: "Please fill in all the fields", presentingController: self)
                }
        
        
    }
    
    func updateContainerViewConstraints(){
        
        if isRegistrationScreen && isLandscapeOrientation!{
            tempContainerViewContraintValue = containerViewAlignmentConstraint.constant
            // Shift the containerView's centerY towards the bottom so that it accomodates for the top padding while in landscape mode ...
            containerViewAlignmentConstraint.constant = (containerView.frame.origin.y)*(-1)
        }
        DispatchQueue.main.async {
            self.view.updateConstraints()
        }

    }
    
    @IBAction func createNewUser(_ sender: AnyObject){
        
        userDescriptionTextField.text = "Mobile Developer"
        useremailIDTextField.text = "bandhavi.vinay@sogeti.se"
        userPasswordTextField.text = "123456"
        userNameTextField.text = "Bandhavi Madam"
        
        if(((emailTextField.text) != nil) && (passwordTextField.text != nil)){
            
            var tempUser:User = User()
            tempUser.emailAddress = useremailIDTextField.text!
            tempUser.fullName = userNameTextField.text!
            tempUser.userDescription = userDescriptionTextField.text!
            
            
            loginViewModel = LoginViewModel(inNewUser:tempUser,inPassword: userPasswordTextField.text!,responseCallback: {(inUser:User) in
                
                print(inUser)
                if (inUser.emailAddress == tempUser.emailAddress){
                    //Proceed to the home screen ...
                    print("Printing user's description - \(String(describing: inUser.userDescription))")
                    tempUser = inUser
                    
                    //Notify the user about successful creation of the new account ...
                    Utility.showAlertPopUp(inTitle: "New User Created", inMessage: "Please check you email and verify the account", presentingController: self)
                    
                    self.closeRegistrationSelected(sender)
                }
                else{
                    Utility.showAlertPopUp(inTitle: "Error", inMessage: "Login Error", presentingController: self)
                }
                
            })
            
        }
        else{
            print("Details empty")
            Utility.showAlertPopUp(inTitle: "Missing Fields", inMessage: "Please fill in all the fields", presentingController: self)
        }
        
    }
    
    //MARK: UITextField Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

