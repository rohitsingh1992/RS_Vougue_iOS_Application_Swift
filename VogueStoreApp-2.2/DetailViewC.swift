//
//  DetailViewC.swift
//  VogueStoreApp
//
//  Created by Rohit Singh on 02/10/16.
//  Copyright © 2016 sra. All rights reserved.
//

import UIKit

class DetailViewC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet var collectionViewProducts: UICollectionView!
    
    
    // Array of Product for dummy data to show inside the collection view
    var arrOfProcucts = [[String:String]]()
    
    // Item count for the added no of items in cart
    var itemCount = 0;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.collectionViewProducts.delegate = self
        self.collectionViewProducts.dataSource = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        self.generateIconsForLeftAndRightNavigationBarButtonsOnDetailView(self.navigationItem, target: self)
        
        self.creatingDummyData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Setting up the Left, Right Navigation Bar button with badge symbol and setting the Navigation Title "Shop"
    
    func generateIconsForLeftAndRightNavigationBarButtonsOnDetailView(navigationItem:UINavigationItem, target: UIViewController) {
        
        
        let attributes = [NSFontAttributeName: UIFont.ioniconOfSize(35),NSForegroundColorAttributeName : UIColor(red: (82 / 255.00), green: (114 / 255.00), blue: (185 / 255.00), alpha: 1)
            ] as Dictionary!
        
        let leftBarButton = UIBarButtonItem(title: String.ioniconWithCode("ion-chevron-left"), style: UIBarButtonItemStyle.Plain, target: self, action: "backButton")
        
        //UIBarButtonItem(title:  String.ioniconWithCode("ion-chevron-left"), style: UIBarButtonItemStyle.Plain, target: target, action: #selector(DetailViewC.backButton))
        leftBarButton.setTitleTextAttributes(attributes, forState: .Normal)
        navigationItem.leftBarButtonItem = leftBarButton
        
        
        navigationItem.title = "Shop"

        
        let image : UIImage = UIImage(named: "cart")!
        let btnRight = UIButton(type: UIButtonType.Custom)
        btnRight.frame = CGRectMake(0, 0, image.size.width, image.size.height)
        btnRight.setBackgroundImage(image, forState: UIControlState.Normal)
        
        let rightBarButton = UIBarButtonItem(customView: btnRight)
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem!.badgeValue = "0";
        navigationItem.backBarButtonItem?.badgeBGColor = UIColor.redColor()
        
        
    }
    
    
    // Custom Method for the back button of the LeftNavogation Bar Button
    func backButton(){
        print("back")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // Collection view delegate and datasource methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrOfProcucts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Getting the reusable cell  by using reuseable Identifier as "cell" and using the Cutomised collection view cell class "CutomCollectionCell"
        let cell : CutomCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CutomCollectionCell
        
        let data = self.arrOfProcucts[indexPath.item]
        let pName = data["pname"]
        let pPrice = data["price"]
        let pImageName = data["pImageName"]
        
        cell.lblProductName.text = pName
        cell.lblPrice.text = pPrice
        cell.imageOfProduct.image = UIImage(named: pImageName!)
        
        cell.btnAddToCart.addTarget(self, action: "addToCart", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
        
        
        

    }
    
    
    // IBAction for the Featured Item Add To Cart Button
    @IBAction func tapFeaturedProductBtn(sender: UIButton) {
        self.addToCart()
    }
    
    
    // Method for Increasing the count of the badge whenever user pressess any of the "Add to cart" button on the screen
    func addToCart(){
        self.itemCount += 1;
        navigationItem.rightBarButtonItem!.badgeValue = "\(self.itemCount)";

    }
    
    
    // Method for creating the Dummy Data to show inside the collection view
    func creatingDummyData() {
        let dict1  = ["pname" : "Sneakers 1",
                      "price" : "$49.95",
                      "pImageName" : "11"]
        
        let dict2  = ["pname" : "Shoes B",
                      "price" : "$79.95",
                      "pImageName" : "12"]
        
        let dict3  = ["pname" : "Dress A",
                      "price" : "$99.90",
                      "pImageName" : "13"]
        
        let dict4  = ["pname" : "Dress B",
                      "price" : "$89.00",
                      "pImageName" : "14"]
        
        let dict5  = ["pname" : "Sneakers 1",
                      "price" : "$49.95",
                      "pImageName" : "11"]
        
        let dict6  = ["pname" : "Shoes B",
                      "price" : "$79.95",
                      "pImageName" : "12"]
        
        let dict7  = ["pname" : "Dress A",
                      "price" : "$99.90",
                      "pImageName" : "13"]
        
        let dict8  = ["pname" : "Dress B",
                      "price" : "$89.00",
                      "pImageName" : "14"]
        
        self.arrOfProcucts.append(dict1)
        self.arrOfProcucts.append(dict2)
        self.arrOfProcucts.append(dict3)
        self.arrOfProcucts.append(dict4)
        self.arrOfProcucts.append(dict5)
        self.arrOfProcucts.append(dict6)
        self.arrOfProcucts.append(dict7)
        self.arrOfProcucts.append(dict8)

        

    }
    
    
    


}
