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
    
    /// UIScrollView
    let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
            gridView.wd_width = width
            gridView.scrollView.wd_width = width
            let itemWidth: CGFloat = width / CGFloat(column)
            let aItemHeight: CGFloat = itemHeight == 0 ? itemWidth : itemHeight
            
            if images.count == titles.count {
                
                for i in 0 ..< images.count {
                    
                    let item = WDGridViewItem()
                    item.wd_width = itemWidth
                    item.wd_height = aItemHeight
                    item.titleLabel.font = UIFont.systemFont(ofSize: titleFont)
                    item.titleLabel.textColor = titleColor
                    item.setImageAndTitle(image: images[i], title: titles[i])
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
                    gridView.addPageControl()
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

extension WDGridView {
    
    func addPageControl() {
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        pageControl.wd_height = 10
        pageControl.currentPage = 0
        pageControl.numberOfPages = Int(scrollView.contentSize.width / wd_width)
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.wd_bottom = wd_height - 10
        pageControl.wd_centerX = wd_width / 2
        
        addSubview(scrollView)
        addSubview(pageControl)
    }
    
}
