//
//  ViewController.swift
//  VogueStoreApp
//
//  Created by Sravanth Kuture on 02/10/16.
//  Copyright © 2016 sra. All rights reserved.
//


// I have used Local Authentication framework for touch id authentication in iOS. 
// It is availbale from iOS 8.0.

import UIKit
import LocalAuthentication


class ViewController: UIViewController {

    @IBOutlet var viewBlackOverLay: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding tap gesture so that when user will click on the black overlay then the view should hide
        
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action: "hideView")
        self.viewBlackOverLay.addGestureRecognizer(tapGesture)
        

        
    }
    
    override func viewWillAppear(animated: Bool) {
        // Hiding Top Navigation Bar
        self.navigationController?.navigationBarHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLoginBtn(sender: UIButton) {
        
        self.viewBlackOverLay.hidden = false

        let context : LAContext = LAContext()
        
        var err : NSError?
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &err)
        {
            [context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Touch id authentication", reply: { (isSuccess : Bool, errLA:NSError?) -> Void in
                
                if isSuccess
                {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVc: HomeViewC =
                        storyBoard.instantiateViewControllerWithIdentifier("HomeViewC") as! HomeViewC
                        self.navigationController?.pushViewController(homeVc, animated: true)
                        Utils.showToastMesaage(self.view, message: "Fingerprint Authentication is successful", delay: 2.0)
                       
                    })
                    
                }
                else
                {
                    switch errLA!.code {
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        self.showOKAlertView("Error", strMessage: "SystemCancel")
                        break;
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by user")
                        self.showOKAlertView("Error", strMessage: "UserCancel")
                        break
                    case LAError.UserFallback.rawValue:
                        self.showOKAlertView("Error", strMessage: "UserFallback");
                        print("User wants to enter password")
                        
                    default:
                        break;
                    }
                    
                }
                
            })]
            
        } else {
            switch err!.code {
                
            case LAError.TouchIDNotAvailable.rawValue:
                print("TouchIDNotAvailable")
                self.showOKAlertView("Error", strMessage: "TouchIDNotAvailable")
                break;
                
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchIDNotEnrolled")
                self.showOKAlertView("Error", strMessage: "TouchIDNotEnrolled")
                
                break;
                
            default:
                break;
                
                
            }
            
            
        }

       
    
    
    }
    
    //MARK: Custom Methods
    func hideView(){
        self.viewBlackOverLay.hidden = true
    }

    
    //MARK: Alert view methods
    
    func showOKAlertView(strTitle : String, strMessage : String){
        let alert : UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
        })
        
        
        alert.addAction(okAction)
        // alert.addAction(cancelAction)
        dispatch_async(dispatch_get_main_queue(), {
            // code here
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
        })    }
    
    func showOKAndCancelAlertView(strTitle : String, strMessage : String){
        let alert : UIAlertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
        })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        dispatch_async(dispatch_get_main_queue(), {
            // code here
            self.presentViewController(alert, animated: true, completion: { () -> Void in
                
            })
        })
        
        
        
    }
    


}

