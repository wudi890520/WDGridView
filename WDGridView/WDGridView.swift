//
//  WDGridView.swift
//  WDGridView
//
//  Created by 吴頔 on 17/2/7.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

typealias selectedIndexBlock = (Int) -> Void


class WDGridView: UIView, UIScrollViewDelegate {

    /// 图片数组
    var images: [UIImage] = []
    
    /// 标题数组
    var titles: [String] = []
    
    /// 点击事件回调
    var selected: selectedIndexBlock?
    
    /// 按钮的数组
    var items: [WDGridViewItem] = []
    
    /// UIPageControl
    let pageControl = WDGridViewPageControl()
    
    let scrollView = UIScrollView()
    
}

extension WDGridView {
    
    /// 生成网格实例
    ///
    /// - Parameters:
    ///   - images: 图片
    ///   - titles: 标题
    ///   - column: 每行有几个元素
    ///   - rowLimit: 最多有几行（会自动向右排列，类似美团首页菜单）
    ///   - width: 网格宽度（默认屏幕宽度）
    ///   - itemHeight: 单个item的高度（默认与高度相等为正方形）
    ///   - titleFont: 标题文字大小
    ///   - titleColor: 标题文字颜色
    /// - Returns: WDGridView
    class func creat(images: [UIImage],
                     titles: [String],
                     column: Int,
                     rowLimit: Int = 0,
                     width: CGFloat = UIScreen.main.bounds.width,
                     itemHeight: CGFloat = 0,
                     titleFont: CGFloat = 13,
                     titleColor: UIColor = UIColor.black)
        -> WDGridView {
            let gridView = WDGridView()
            gridView.backgroundColor = UIColor.white
            gridView.wd_width = width
            gridView.scrollView.wd_width = width
            let itemWidth: CGFloat = width / CGFloat(column)
            let aItemHeight: CGFloat = itemHeight == 0 ? itemWidth : itemHeight
            
            if images.count == titles.count {
                
                for i in 0 ..< images.count {
                    
                    let item = WDGridViewItem()
                    item.wd_width = itemWidth
                    item.wd_height = aItemHeight
                    item.image = images[i]
                    item.title = titles[i]
                    item.titleLabel.font = UIFont.systemFont(ofSize: titleFont)
                    item.titleLabel.textColor = titleColor
                    item.button.tag = i
                    
                    if rowLimit == 0 {
                        item.wd_top = CGFloat(i / column) * aItemHeight
                        item.wd_left = CGFloat(i % column) * itemWidth
                        gridView.addSubview(item)
                        gridView.wd_height = item.wd_bottom
                    }else{
                        let pages = images.count % (column*rowLimit) == 0 ? images.count / (column*rowLimit) : images.count / (column*rowLimit) + 1
                        gridView.scrollView.contentSize = CGSize(width: width * CGFloat(pages), height: aItemHeight * CGFloat(rowLimit))
                        gridView.scrollView.wd_height = aItemHeight * CGFloat(rowLimit)
                        gridView.wd_height = aItemHeight * CGFloat(rowLimit) + 20
                        
                        item.wd_top = CGFloat(i % (column*rowLimit) / column) * aItemHeight
                        item.wd_left = CGFloat(i % column) * itemWidth + CGFloat(i / (column*rowLimit)) * width
                        gridView.scrollView.addSubview(item)
                       
                    }

                    gridView.items.append(item)
                    item.button.addTarget(gridView, action: #selector(gridView.buttonAction(button:)), for: .touchUpInside)
                    
                }
                
                if rowLimit != 0 {
                    gridView.scrollView.showsVerticalScrollIndicator = false
                    gridView.scrollView.showsHorizontalScrollIndicator = false
                    gridView.addSubview(gridView.scrollView)
                    gridView.scrollView.delegate = gridView
                    gridView.scrollView.isPagingEnabled = true
                    gridView.pageControl.wd_height = 10
                    gridView.pageControl.currentPage = 0
                    gridView.pageControl.numberOfPages = Int(gridView.scrollView.contentSize.width / width)
                    gridView.pageControl.currentPageIndicatorTintColor = UIColor.gray
                    gridView.pageControl.pageIndicatorTintColor = UIColor.lightGray
                    gridView.pageControl.wd_bottom = gridView.wd_height-10
                    gridView.pageControl.wd_centerX = width / 2
                    gridView.addSubview(gridView.pageControl)
                }
                
                
            }else{
                print("图片与标题数组错误❌")
            }
            
            return gridView
        
    }
    
}

extension WDGridView {
    
    /// 点击事件
    ///
    /// - Parameter button: UIButton
    func buttonAction(button: UIButton) {
        if selected != nil {
            selected!(button.tag)
        }
    }
}

extension WDGridView {
    
    /// 取出某个item
    ///
    /// - Parameter index: index
    /// - Returns: WDGridViewItem
    func at(index: Int) -> WDGridViewItem {
        return items[index]
    }
    
}

extension WDGridView {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / wd_width)
    }
    
}

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
