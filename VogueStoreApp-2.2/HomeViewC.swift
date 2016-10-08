//
//  HomeViewC.swift
//  VogueStoreApp
//
//  Created by Rohit Singh on 02/10/16.
//  Copyright © 2016 sra. All rights reserved.
//

import UIKit




class HomeViewC: UIViewController, MyProtocol {
    
    @IBOutlet var scrollView: SraScrollView!
    @IBOutlet var lblImageShop: UILabel!
    @IBOutlet var lblImageEvents: UILabel!
    @IBOutlet var lblImageBook: UILabel!
    @IBOutlet var lblImageOffer: UILabel!
    @IBOutlet var lblImageLoylity: UILabel!
    

    
    @IBOutlet var lblOffer: UILabel!
    @IBOutlet var lblOfferDesc: UILabel!
    @IBOutlet var lblLoyalty: UILabel!
    @IBOutlet var lblPoints: UILabel!
    var indexOfImage = 1

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        settingUpIcons()
        
        self.navigationController?.navigationBarHidden = false
        // It is method inside the Utils file which is used for creating icon on the left and right navigation bar buttons
        Utils.generateIconsForLeftAndRightNavigationBarButtons(self.navigationItem,target: self)
        
        // Here i am creating the image to be placed on the center of the Navigaation Bar
        let imgTitleBar = UIImage(named: "logoicon");
        let imageView = UIImageView(image: imgTitleBar)
        self.navigationItem.titleView = imageView
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        
        var arrOfImages = [UIImageView]()
        
        self.scrollView.contentSize = CGSize(width: 4 * self.view.frame.width, height: self.scrollView.frame.height-30)
        
        for i in 0 ..< 4 {
            
            
            // Creating UIImageview Frame...
            
            let size = self.scrollView.frame.size
            let height  = size.height + 0.0;
            
            let imageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, CGFloat(self.view.frame.width), height - 30))
            
            
            // Name of the Image
            let strNameOfImage = "\(i+1)"
            
            // Creating UIImage Object by getting name of the image from assets and assigning it to the UIImageView
            imageView.image = UIImage(named:strNameOfImage)
            
            
            // Adding Tap Gesture On Image to detect the index of the selected image on the scrollview
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapImageOnScroll")
            
            imageView.userInteractionEnabled = true
            
            
            
            // White View On the 3rd and 4th Image on the scroll view
            let yAxisOfWhiteView = imageView.frame.size.height - 80
            
            let viewWhite: UIView = UIView(frame: CGRectMake(0, yAxisOfWhiteView, CGFloat((self.view.frame.width * 2) / 3) - 30, 60))
            viewWhite.backgroundColor = UIColor.whiteColor()
            viewWhite.alpha = 0.7
            
           

            
            if i == 2 {
                
                let lblWhiteMain : UILabel = UILabel(frame: CGRectMake(0, 5, CGFloat(viewWhite.frame.width), 25))
                //lblWhiteMain.backgroundColor = UIColor.greenColor()
                lblWhiteMain.font = UIFont(name: "Helvetica-Bold", size: 16)
                lblWhiteMain.text = "Fashion Show"
                lblWhiteMain.textAlignment = NSTextAlignment.Center
                
                let lblWhiteDate : UILabel = UILabel(frame: CGRectMake(0, lblWhiteMain.frame.size.height + 7, CGFloat(viewWhite.frame.width), 20))
                
                //lblWhiteDate.backgroundColor = UIColor.redColor()
                lblWhiteDate.font = UIFont(name: "Helvetica", size: 13)
                lblWhiteDate.text = "December 1st 2015"
                lblWhiteDate.textAlignment = NSTextAlignment.Center
                
                viewWhite.addSubview(lblWhiteMain)
                viewWhite.addSubview(lblWhiteDate)
            } else if i == 3 {
            
                
                let lblWhiteMain : UILabel = UILabel(frame: CGRectMake(0, (viewWhite.frame.height - 25) / 2, CGFloat(viewWhite.frame.width), 25))
                //lblWhiteMain.backgroundColor = UIColor.greenColor()
                lblWhiteMain.font = UIFont(name: "Helvetica-Bold", size: 16)
                lblWhiteMain.text = "Personal Shoper"
                lblWhiteMain.textAlignment = NSTextAlignment.Center
                
                
                viewWhite.addSubview(lblWhiteMain)

            }
           
            
            // Blue view on the 3rd and 4th image
            let xAxisOfBlueView = viewWhite.frame.size.width - 20
            let yAxisOfBlueView = yAxisOfWhiteView + 10

            
            
            let viewBlue: UIView = UIView(frame: CGRectMake(xAxisOfBlueView, yAxisOfBlueView, CGFloat((viewWhite.frame.size.width * 2) / 3) - 15, 40))
            viewBlue.backgroundColor = UIColor(red: (82 / 255.00), green: (114 / 255.00), blue: (185 / 255.00), alpha: 1)
            
            let lblBlueMain : UILabel = UILabel(frame: CGRectMake(0, (viewBlue.frame.size.height - 30 ) / 2, CGFloat(viewBlue.frame.width) - 20, 30))
            //lblWhiteMain.backgroundColor = UIColor.greenColor()
            lblBlueMain.font = UIFont(name: "Helvetica-Bold", size: 14)
            if i == 2 {
                lblBlueMain.text = "Get Tickets"

            } else if i == 3 {
                lblBlueMain.text = "Book Now"

            }
            lblBlueMain.textColor = UIColor.whiteColor()
            lblBlueMain.textAlignment = NSTextAlignment.Center
            
            let lblBlueArrow : UILabel = UILabel(frame: CGRectMake(lblBlueMain.frame.size.width, (viewBlue.frame.size.height - 30 ) / 2, 30, 30))
            
            lblBlueArrow.text = String.ioniconWithCode("ion-chevron-right")
            lblBlueArrow.textColor = UIColor.whiteColor()
            lblBlueArrow.font = UIFont.ioniconOfSize(20)
            
            viewBlue.addSubview(lblBlueMain)
            viewBlue.addSubview(lblBlueArrow)


            if i >= 2 {
                imageView.addSubview(viewWhite)
                imageView.addSubview(viewBlue)

            }
            imageView.addGestureRecognizer(tapGesture)
        
        // 1
        arrOfImages.append(imageView)
            
        }
        
        scrollView.myDelegate = self
        
        // 2
        scrollView?.numPages = arrOfImages.count
        scrollView?.viewObjects = arrOfImages
        scrollView.pagingEnabled = true
        
        // 3
        scrollView?.setup()
        
        // Calling the Api to get the Loyalty Points
        
        
        // Creating a prameter dictionary
         let dict = ["username":"Michael","grandTotal":"0"]
        
        
        // Checking the internet connection
        if WebConnection.isInternetConnected() {
            
            Utils.startActivityIndicator("Please wait !!", detailMessage: nil, onView: self.view)
            
            WebConnection.callStringWebServiceWithUrl(nil, time: 60, isPost: true, headers: nil, params: dict) { (data:NSDictionary?) in
                
                dispatch_async(dispatch_get_main_queue(), { 
                    Utils.stopActivityIndicator()
                })
                
                
                // Checking the data got from the API  whether it is nil or not
                
                if let unwrapResponse = data {
                    
                    
                    // Getting the rewrad points from dictionary
                    let rewardPoints = unwrapResponse["rewardPoints"]!.stringValue
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        // Assignign the reward point on the lable
                        self.lblPoints.text = rewardPoints as String + " pts"
                    })

                    
                }
                
            }
        } else {
            Utils.showToastMesaage(self.view, message: "Internet is not availabe. Please check your internet connection and try again", delay: 2)
        }
        
       
         
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func backButton(){
        print("back")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tapShopBtn(sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc: DetailViewC = storyBoard.instantiateViewControllerWithIdentifier("DetailViewC") as! DetailViewC
        self.navigationController?.pushViewController(detailVc, animated: true)
    
    }
    
    @IBAction func tapEventBtn(sender: UIButton) {
    }
    
    @IBAction func tapBookPersonal(sender: UIButton) {
    }
    
    @IBAction func tapOffer(sender: UIButton) {
    }
    
    @IBAction func tapLoyaltyBtn(sender: UIButton) {
    }
    
   
    
    //MARK: Delegate Methods Implementaion
    
    func sendPageNumber(pageNumber: Int) {
        indexOfImage = pageNumber + 1
        print(indexOfImage)

    }
    
    //MARK: Custom methods 
    func settingUpIcons(){

        self.lblImageShop.text = String.ioniconWithCode("ion-android-cart")
        self.lblImageShop.textColor = UIColor.whiteColor()
        self.lblImageShop.font = UIFont.ioniconOfSize(20)
        
        self.lblImageEvents.text = String.ioniconWithCode("ion-calendar")
        self.lblImageEvents.textColor = UIColor.whiteColor()
        self.lblImageEvents.font = UIFont.ioniconOfSize(20)
        
        self.lblImageBook.text = String.ioniconWithCode("ion-bag")
        self.lblImageBook.textColor = UIColor.whiteColor()
        self.lblImageBook.font = UIFont.ioniconOfSize(20)
        
        self.lblImageOffer.text = String.ioniconWithCode("ion-pricetag")
        self.lblImageOffer.textColor = UIColor.whiteColor()
        self.lblImageOffer.font = UIFont.ioniconOfSize(20)
        
        self.lblImageLoylity.text = String.ioniconWithCode("ion-trophy")
        self.lblImageLoylity.textColor = UIColor.whiteColor()
        self.lblImageLoylity.font = UIFont.ioniconOfSize(20)
        
        
        
    }
    
    func tapImageOnScroll(){
        print("tapon image")
    
    }

}
