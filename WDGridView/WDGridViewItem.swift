//
//  WDGridViewItem.swift
//  WDGridView
//
//  Created by 吴頔 on 17/2/7.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

private let MAXFLOAT = 0x1.fffffep+127

class WDGridViewItem: UIView {
    
    /// 未读数量
    var badgeValue: String {
        set {
            
            badge.isHidden = newValue == "0"
            
            badge.text = newValue
            var attr = Dictionary<String, Any>()
            attr[NSFontAttributeName] = badge.font
            let rect = NSString(string: newValue).boundingRect(with: CGSize(width: MAXFLOAT, height: MAXFLOAT), options: [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.usesFontLeading], attributes: attr, context: nil)
            
            if newValue.characters.count == 1 {
                badge.wd_width = badge.wd_height
            }else{
                badge.wd_width = rect.size.width + 10
            }
            
            badge.wd_centerX = imageView.wd_right
            badge.wd_centerY = imageView.wd_top
        }
        get {
            return badge.text!
        }
    }
    
    /// 隐藏红点
    var isPointHidden: Bool {
        set {
            point.isHidden = newValue
        }
        get {
            return point.isHidden
        }
    }
    
    
    var imageView = UIImageView()
    var titleLabel = UILabel()
    var button = UIButton()
    var point = UIView()
    var badge = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(button)
        
        titleLabel.textAlignment = .center

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WDGridViewItem {
    
    /// 添加红点
    ///
    /// - Parameters:
    ///   - height: 红点大小
    ///   - color: 红点颜色
    func addPoint(height: CGFloat = 6,
                  color: UIColor = UIColor.red) {
        point.wd_height = height
        point.wd_width = height
        point.wd_left = imageView.wd_right
        point.wd_bottom = imageView.wd_top
        point.layer.cornerRadius = point.wd_width / 2
        point.layer.masksToBounds = true
        point.backgroundColor = color
        addSubview(point)
    }
    
    /// 添加未读badge
    ///
    /// - Parameters:
    ///   - fontSize: 文字大小
    ///   - textColor: 文字颜色
    ///   - backgroundColor: 背景颜色
    func addBadge(fontSize: CGFloat = 13,
                  textColor: UIColor = UIColor.white,
                  backgroundColor: UIColor = UIColor.red) -> WDGridViewItem {
        badge.textColor = textColor
        badge.backgroundColor = backgroundColor
        badge.font = UIFont.systemFont(ofSize: fontSize)
        badge.wd_height = fontSize + 4
        badge.textAlignment = .center
        badge.layer.cornerRadius = badge.wd_height / 2
        badge.layer.masksToBounds = true
        addSubview(badge)
        
        return self
    }

}

extension WDGridViewItem {
    func setImageAndTitle(image: UIImage, title: String) {
        imageView.wd_size = image.size
        imageView.wd_centerX = wd_width / 2
        
        titleLabel.wd_width = wd_width
        titleLabel.wd_centerX = wd_width / 2
        titleLabel.wd_height = titleLabel.font.pointSize
        
        let totalSpace = wd_height - imageView.wd_height - titleLabel.wd_height
        let topAndBottomSpace = totalSpace / 5 * 2
        
        imageView.wd_top = topAndBottomSpace
        titleLabel.wd_bottom = wd_height - topAndBottomSpace
        
        imageView.image = image
        titleLabel.text = title
        
        button.wd_width = wd_width
        button.wd_height = wd_height
    }
}
