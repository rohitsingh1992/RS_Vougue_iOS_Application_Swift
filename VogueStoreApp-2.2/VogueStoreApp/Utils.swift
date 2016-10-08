//
//  Utils.swift
//  VideoChat
//
//  Created by Rohit Singh on 09/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

import UIKit
import MBProgressHUD


class Utils: NSObject {
    
    static var hud : MBProgressHUD? = nil
    
    class func startActivityIndicator(title:String?,detailMessage : String?, onView: UIView){
        
        self.hud =  MBProgressHUD.showHUDAddedTo(onView, animated: true)
        self.hud!.mode = MBProgressHUDMode.Indeterminate
        if let unwarpTitle = title {
            self.hud!.label.text = unwarpTitle
            
        }
        if let unwarpDetailsMessage = detailMessage {
            self.hud!.detailsLabel.text = unwarpDetailsMessage
            
        }
        
      //  print("hud\(hud)")
        self.hud!.showAnimated(true)
    }
    
    class func stopActivityIndicator(){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            if let unwrapHud = self.hud {
                unwrapHud.hidden = true
            } else {
                print("MBProgressHUD is not initialized yet!!!")
            }
        })
    }
    
    class func showToastMesaage(toView : UIView,message : String?,delay : NSTimeInterval){
        self.hud = nil
        self.hud = MBProgressHUD.showHUDAddedTo(toView, animated: true)
        self.hud?.mode = MBProgressHUDMode.Text
        self.hud!.margin = 10;
        self.hud!.offset.y = 150;
        
        if let unwrapString = message {
            self.hud!.detailsLabel.text = unwrapString;
        }
        self.hud!.removeFromSuperViewOnHide = true
    
        self.hud!.hideAnimated(true, afterDelay: delay)
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    class func isValidPhone(value: String) -> Bool {
        
       // let PHONE_REGEX = "^\\+\\d{3}-\\d{2}-\\d{7}$"
        let PHONE_REGEX = "^[2-9]{2}[0-9]{8}$"

        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluateWithObject(value)
        
        return result
        
    }

    class func showAlertViewOnViewController(viewC : UIViewController,title: String, message: String){
    
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        let okAction : UIAlertAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
            
        }
        alert.addAction(okAction)
        viewC.presentViewController(alert, animated: true) { () -> Void in
            
        }
        
    }
    
    class func createTopStatusBarOnView(view:UIView) -> UIView {
    let statusBarView  = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
    statusBarView.backgroundColor = UIColor.blackColor()
    statusBarView.alpha = 0.9
    return statusBarView
    }
    
    
    class func generateIconsForLeftAndRightNavigationBarButtons(navigationItem:UINavigationItem, target: UIViewController) {
        let attributes = [NSFontAttributeName: UIFont.ioniconOfSize(40),NSForegroundColorAttributeName : UIColor(red: (82 / 255.00), green: (114 / 255.00), blue: (185 / 255.00), alpha: 1)
            ] as Dictionary!
        
        let leftBarButton = UIBarButtonItem(title:  String.ioniconWithCode("ion-navicon"), style: UIBarButtonItemStyle.Plain, target: target, action: Selector("backButton"))
        
        leftBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        rightBarButton.title = String.ioniconWithCode("ion-person")
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
  
    
}
