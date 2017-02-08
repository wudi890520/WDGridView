//
//  WDGridViewPageControl.swift
//  WDGridView
//
//  Created by 吴頔 on 17/2/8.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class WDGridViewPageControl: UIPageControl {

    override var currentPage: Int {
        set {
            super.currentPage = newValue
            for subviewIndex in 0 ..< subviews.count {
                let subview = subviews[subviewIndex]
                let pointHeight: CGFloat = 6
                
                subview.frame = CGRect(x: subview.wd_left, y: subview.wd_top, width: pointHeight, height: pointHeight)
                subview.layer.cornerRadius = pointHeight/2
                if subviewIndex == newValue {
                    subview.backgroundColor = UIColor.red
                }else{
                    subview.backgroundColor = UIColor.lightGray
                }
            }
        }
        get {
            return super.currentPage
        }
    }

}
