//
//  ViewController.swift
//  WDGridView
//
//  Created by 吴頔 on 17/2/7.
//  Copyright © 2017年 WD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var grid: WDGridView!
    var grid1: WDGridView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        initGrid()  ///demo 1
        initGrid1() ///demo 2

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    func initGrid() {
        let images = [#imageLiteral(resourceName: "homeItemQR"),#imageLiteral(resourceName: "homeItemFindGoods"),#imageLiteral(resourceName: "homeItemHistory"),#imageLiteral(resourceName: "homeItemShare"),#imageLiteral(resourceName: "homeItemUserInfo"),#imageLiteral(resourceName: "homeItemMessage"),#imageLiteral(resourceName: "homeItemSystemSetting"),#imageLiteral(resourceName: "homeItemSystemSetting"),#imageLiteral(resourceName: "homeItemSystemSetting"),#imageLiteral(resourceName: "homeItemSystemSetting")]
        let titles = ["扫码找单","找回头车","历史运单","邀请好友","我的资料","消息通知","系统设置","系统设置","系统设置","系统设置"]
        
        let itemHeight = UIScreen.main.bounds.width / 4 - 10
        
        
        let gridView = WDGridView.creat(images: images,
                                        titles: titles,
                                        column: 3,
                                        itemHeight: itemHeight,
                                        titleFont: 12)
        gridView.wd_top = 40
        view.addSubview(gridView)
        
        gridView.selected = {[weak self] (index) in
            switch index {
            case 4:
                self?.changeInfoPointIsHidden()
            case 5:
                self?.changeMessageBadgeValue()
            default:
                print(index)
            }
        }
        
        gridView.at(index: 0).backgroundColor = UIColor.lightGray
        gridView.at(index: 1).addBadge(fontSize: 8).badgeValue = "热门"
        gridView.at(index: 4).addPoint(height: 6, color: UIColor.red)
        gridView.at(index: 5).addBadge().badgeValue = "16"
        grid = gridView
    }
    
    func initGrid1() {
        let images = [#imageLiteral(resourceName: "i0"),#imageLiteral(resourceName: "i1"),#imageLiteral(resourceName: "i2"),#imageLiteral(resourceName: "i3"),#imageLiteral(resourceName: "i4"),#imageLiteral(resourceName: "i5"),#imageLiteral(resourceName: "i6"),#imageLiteral(resourceName: "i0"),#imageLiteral(resourceName: "i1"),#imageLiteral(resourceName: "i2"),#imageLiteral(resourceName: "i3"),#imageLiteral(resourceName: "i4"),#imageLiteral(resourceName: "i5"),#imageLiteral(resourceName: "i6")]
        let titles = ["扫码找单","找回头车","历史运单","邀请好友","我的资料","消息通知","系统设置","扫码找单","找回头车","历史运单","邀请好友","我的资料","消息通知","系统设置"]
        
        let itemHeight = UIScreen.main.bounds.width / 4 - 30
        
        
        let gridView = WDGridView.creat(images: images,
                                        titles: titles,
                                        column: 4,
                                        rowLimit: 2,
                                        itemHeight: itemHeight,
                                        titleFont: 12)
        gridView.wd_top = grid.wd_bottom + 50
        view.addSubview(gridView)
        
        gridView.selected = { (index) in
            print(index)
        }

        grid1 = gridView
    }
}

extension ViewController {
    
    func changeMessageBadgeValue() {
        let messageItem = grid.at(index: 5)
        
        if messageItem.badgeValue == "0" {
            messageItem.badgeValue = "3"
        }else if messageItem.badgeValue == "3" {
            messageItem.badgeValue = "59"
        }else{
            messageItem.badgeValue = "0"
        }
    }
    
    func changeInfoPointIsHidden() {
        
        let infoItem = grid.at(index: 4)
        
        infoItem.isPointHidden = !infoItem.isPointHidden
    }
}
