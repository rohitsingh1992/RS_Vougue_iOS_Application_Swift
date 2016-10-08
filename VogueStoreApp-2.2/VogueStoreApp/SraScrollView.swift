//
//  SraScrollView.swift
//  VogueStoreApp
//
//  Created by Rohit Singh on 02/10/16.
//  Copyright © 2016 sra. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func sendPageNumber(pageNumber:Int);
}


class SraScrollView: UIScrollView, UIScrollViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
    var myDelegate : MyProtocol!

    
    var pageControl: UIPageControl?
    // 1
    var viewObjects: [UIView]?
    var numPages: Int = 0
    
    // 2
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        pagingEnabled = true
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        scrollsToTop = false
        delegate = self
        
        
        
        

    }
    
    // 3
    func setup() {
        guard let parent = superview else { return }
        
        contentSize = CGSize(width: (frame.size.width * (CGFloat(numPages) + 2)), height: frame.size.height - 50)
        

        pageControl = UIPageControl(frame: CGRect(x: 0, y: (parent.frame.size.height / 2) - 10 , width: parent.frame.size.width, height: 30))
        pageControl!.pageIndicatorTintColor = UIColor.grayColor()
        pageControl?.currentPageIndicatorTintColor = UIColor(red: (82 / 255.00), green: (114 / 255.00), blue: (185 / 255.00), alpha: 1)
    
        
       
        pageControl?.numberOfPages = numPages
        pageControl?.currentPage = 0
        pageControl?.userInteractionEnabled = false
        parent.addSubview(pageControl!)
        
        loadScrollViewWithPage(0)
        loadScrollViewWithPage(1)
        loadScrollViewWithPage(2)
        
        var newFrame = frame
        newFrame.origin.x = newFrame.size.width
        newFrame.origin.y = 0
        scrollRectToVisible(newFrame, animated: false)
        
        layoutIfNeeded()
    }
    // 4
    private func loadScrollViewWithPage(page: Int) {
        if page < 0 { return }
        if page >= numPages + 2 { return }
        
        var index = 0
        
        if page == 0 {
            index = numPages - 1
        } else if page == numPages + 1 {
            index = 0
        } else {
            index = page - 1
        }
        
        let view = viewObjects?[index]
        
        var newFrame = frame
        newFrame.origin.x = frame.size.width * CGFloat(page)
        newFrame.origin.y = 0
        view?.frame = newFrame
        
        if view?.superview == nil {
            addSubview(view!)
        }
        
        layoutIfNeeded()
    }
    
    // 5
    @objc internal func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = frame.size.width
        let page = floor((contentOffset.x - (pageWidth/2)) / pageWidth) + 1
        pageControl?.currentPage = Int(page - 1)
        
        loadScrollViewWithPage(Int(page - 1))
        loadScrollViewWithPage(Int(page))
        loadScrollViewWithPage(Int(page + 1))
        
        
        
    }
    
    // 6
    @objc internal func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = frame.size.width
        let page : Int = Int(floor((contentOffset.x - (pageWidth/2)) / pageWidth) + 1)
        
        if page == 0 {
            contentOffset = CGPoint(x: pageWidth*(CGFloat(numPages)), y: 0)
        } else if page == numPages+1 {
            contentOffset = CGPoint(x: pageWidth, y: 0)
        }
        
        if self.myDelegate != nil {
            self.myDelegate.sendPageNumber((pageControl?.currentPage)!)
        }
    }
    
   
    
}
