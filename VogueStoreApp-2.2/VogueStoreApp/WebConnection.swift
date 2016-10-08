//
//  WebConnection.swift
//  VideoChat
//
//  Created by Rohit Singh on 08/12/15.
//  Copyright © 2015 Home. All rights reserved.
//

import UIKit
import AFNetworking
import Reachability


class WebConnection: NSObject {
    
    
     //let kAPIHost = "http://zabius.com/minimovers/mobile/"
    
    
    class func isInternetConnected() -> Bool {
        let reach : Reachability =  Reachability.reachabilityForInternetConnection()
        let netStatus : NetworkStatus = reach.currentReachabilityStatus()
        
        if (netStatus == NetworkStatus.NotReachable)
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
    class func callStringWebServiceWithUrl(urlString:String?,
                                     time : NSTimeInterval,
                                     isPost:Bool,
                                     headers:Dictionary<String,AnyObject>?,
                                     params:Dictionary<String, AnyObject>?,
                                     completionHandler:NSDictionary? -> Void)
    {
        print(kAPIHost)
        print(params)
        
//        [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
        
    
        
       let request : NSMutableURLRequest = AFHTTPRequestSerializer().requestWithMethod("POST", URLString: kAPIHost, parameters: params, error: nil)
        
        let session = NSURLSession.sharedSession()
        
        if (WebConnection.isInternetConnected())
        {
            session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response : NSURLResponse?, err : NSError?) -> Void in
                
                if data != nil {
                    
                    let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Body: \(strData)")
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                        {
                            //let success = json["success"] as? Int
                            // Okay, the `json` is here, let's get the value for 'success' out of it
                            //print("Success: \(success)")
                            print("jsonResponse is \(json)")
                            completionHandler(json)
                        }
                        else
                        {
                            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                            // No error thrown, but not NSDictionary
                            print("Error could not parse JSON: \(jsonStr)")
                            completionHandler(nil)
                        }
                    }
                    catch let parseError {
                        print(parseError)
                        // Log the error thrown by `JSONObjectWithData`
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: '\(jsonStr)'")
                        completionHandler(nil)
                    }
                } else {
                    completionHandler(nil)
                }
                
            }).resume();
        }


        
    }
    

    
    
    
    class func callWebServiceWithUrl(urlString:String,
        time : NSTimeInterval,
        isPost:Bool,
        headers:Dictionary<String,AnyObject>?,
        params:Dictionary<String, AnyObject>?,
        completionHandler:NSDictionary? -> Void)
    {
        let session = NSURLSession.sharedSession()
        
        let finalString = String(format: "%@%@", arguments: [kAPIHost,urlString])
        
        print("finalString\(finalString)")
        let url:NSURL = NSURL(string: finalString)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: time)
        
        if isPost == true
        {
            request.HTTPMethod = "POST"
        }
        else
        {
            request.HTTPMethod = "GET"
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let unwarp = params{
            request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(unwarp, options: .PrettyPrinted)
            
            do {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(unwarp, options: NSJSONWritingOptions.init(rawValue: 2))
            } catch {
                // Error Handling
                print("NSJSONSerialization Error")
                return
            }
            
        }
        
        if (WebConnection.isInternetConnected())
        {
            session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response : NSURLResponse?, err : NSError?) -> Void in
                
                if data != nil {
                
                let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                    {
                        //let success = json["success"] as? Int
                        // Okay, the `json` is here, let's get the value for 'success' out of it
                        //print("Success: \(success)")
                        print("jsonResponse is \(json)")
                        completionHandler(json)
                    }
                    else
                    {
                        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        // No error thrown, but not NSDictionary
                        print("Error could not parse JSON: \(jsonStr)")
                        completionHandler(nil)
                    }
                }
                catch let parseError {
                    print(parseError)
                    // Log the error thrown by `JSONObjectWithData`
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: '\(jsonStr)'")
                    completionHandler(nil)
                }
                } else {
                completionHandler(nil)
                }
                
            }).resume();
        }
    }
    
    
    class func callUploadImageAtUrl(urlString:String,withArrayOfImages:[UIImage],completionHandler : (NSDictionary?, NSError?) -> Void){
        
        //  let finalString = String(format: "%@%@", arguments: [kAPIHost,urlString])
        //   let strServerUrl:NSURL = NSURL(string: finalString)!
        
        let request : NSMutableURLRequest  = AFHTTPRequestSerializer().multipartFormRequestWithMethod("POST", URLString: "http://zabius.com/uploadtest/serverupload/upload.php", parameters: nil, constructingBodyWithBlock: { (formData:AFMultipartFormData) -> Void in
            
            for var i = 1; i <= withArrayOfImages.count; i += 1 {
                let image = withArrayOfImages [i-1] as UIImage
                let imageData = UIImageJPEGRepresentation(image, 0.6)
                
                let time : NSTimeInterval = NSDate().timeIntervalSince1970
                let nameOfImage = NSString(format: "%d-%d-%@",i, time, NSString(format: "image%d.jpeg", i))
                
                formData.appendPartWithFileData(imageData!, name: "uploaded_file", fileName: nameOfImage as String, mimeType: "image/jpeg")
            }
            }, error: nil)
        
        let manager : AFURLSessionManager = AFURLSessionManager(sessionConfiguration: NSURLSessionConfiguration())
        
        
        
        
        
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let uploadTask : NSURLSessionUploadTask!
        
        uploadTask = manager.uploadTaskWithStreamedRequest(request, progress: { (progress : NSProgress) -> Void in
            
            print("uploaded succesfully")
            
            }, completionHandler: { (response : NSURLResponse, data : AnyObject?, err : NSError?) -> Void in
                if err != nil {
                    print(err.debugDescription)
                    completionHandler(nil,err!)

                } else {
                    print("image/images uploaded succesfully")
                    let dict : NSDictionary = data as! NSDictionary
                    completionHandler(dict,nil)
                    
                }
        })
        
        uploadTask.resume()
        
        
    }
    
    class  func callUploadVideoAtUrl(urlString:String,withArrayOfVideoUrls:[NSURL],withParams:Dictionary<String, AnyObject>?, completionHandler : (NSDictionary?, NSError?,Double,Bool) -> Void){
        
        let finalString = String(format: "%@%@", arguments: [kAPIHost,urlString])
        
        if WebConnection.isInternetConnected() == false
        {
            return
        }
       
        
        let  request : NSMutableURLRequest  = AFHTTPRequestSerializer().multipartFormRequestWithMethod("POST", URLString: finalString, parameters: withParams, constructingBodyWithBlock: { (formData:AFMultipartFormData) -> Void in
            
        
            for var i = 1; i <= withArrayOfVideoUrls.count; i++
            {
                let withUrlOfVideo = withArrayOfVideoUrls [i-1] as NSURL
                let time : NSTimeInterval = NSDate().timeIntervalSince1970
                let nameOfVideo = NSString(format: "%d-%d-%@",i, time, NSString(format: "video%d.mov", i))
                
                do{
                try formData.appendPartWithFileURL(withUrlOfVideo, name: "uploaded_file", fileName: nameOfVideo as String, mimeType: "video/mov")
                    }
                    catch
                    {
                        print("error in form data")
                        
                }

            }
            
            }, error: nil)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        //[request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")

        
        request.timeoutInterval = 200
        
        let manager : AFURLSessionManager = AFURLSessionManager(sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        let uploadTask : NSURLSessionUploadTask!
        
        uploadTask = manager.uploadTaskWithStreamedRequest(request, progress: { (progress : NSProgress) -> Void in
            
            
            print("Progress\(progress.fractionCompleted)")
            
            completionHandler(nil, nil,progress.fractionCompleted,false)

            
            }, completionHandler: { (response : NSURLResponse, data : AnyObject?, err : NSError?) -> Void in
                
                if err != nil {
                    print(err.debugDescription)
                    completionHandler(nil,err!,1,false)
                    
                } else {
                    print("video/videos uploaded succesfully")
                    let strData = NSString(data: data! as! NSData, encoding: NSUTF8StringEncoding)
                    print("Body: \(strData)")
                   
                    do {
                        if let json = try NSJSONSerialization.JSONObjectWithData(data! as! NSData, options: []) as? NSDictionary
                        {
                            print("jsonResponse is \(json)")
                            completionHandler(json, nil,1,true)
                        }
                       
                    }
                    catch let parseError {
                        print(parseError)
                        // Log the error thrown by `JSONObjectWithData`
                        let jsonStr = NSString(data: data! as! NSData, encoding: NSUTF8StringEncoding)
                        print("Error could not parse JSON: '\(jsonStr)'")
                        let errorInfo = NSError(domain: "error", code: 100, userInfo: nil)
                        completionHandler(nil,errorInfo,1,true)
                    }
                    //completionHandler(dict,nil)
                    
                }
        })
        
        uploadTask.resume()
        
        
    }
    
    
    
    /*class func callWebServiceWithUrl(urlString:String,
    isPost:Bool,
    headers:Dictionary<String,AnyObject>?,
    params:Dictionary<String, AnyObject>,
    completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)
    {
    let session = NSURLSession.sharedSession()
    
    let finalString = String(format: "%@%@", arguments: ["",urlString])
    let url:NSURL = NSURL(string: finalString)!
    
    let request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
    
    if isPost == true
    {
    request.HTTPMethod = "POST"
    }
    else
    {
    request.HTTPMethod = "GET"
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
    
    do {
    request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.init(rawValue: 2))
    } catch {
    // Error Handling
    print("NSJSONSerialization Error")
    return
    }
    
    
    
    if (WebConnection.isConnected())
    {
    // session.dataTaskWithRequest(request, completionHandler: completionHandler)!.resume()
    
    session.dataTaskWithRequest(request, completionHandler: { (data: NSData?, response : NSURLResponse?, err : NSError?) -> Void in
    
    let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
    print("Body: \(strData)")
    
    
    
    do {
    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
    let success = json["success"] as? Int
    // Okay, the `json` is here, let's get the value for 'success' out of it
    print("Success: \(success)")
    } else {
    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
    // No error thrown, but not NSDictionary
    print("Error could not parse JSON: \(jsonStr)")
    }
    } catch let parseError {
    print(parseError)
    // Log the error thrown by `JSONObjectWithData`
    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
    print("Error could not parse JSON: '\(jsonStr)'")
    }
    
    }).resume();
    }
    }*/
    
}
