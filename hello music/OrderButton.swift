//
//  OrderButton.swift
//  hello music
//
//  Created by 樊树康 on 16/7/25.
//  Copyright © 2016年 樊树康. All rights reserved.
//

import UIKit

class OrderButton: UIButton {

   var order  = 1
    //顺序播放
    let order1 = UIImage(named: "order1")
    //随机播放
    let order2 = UIImage(named: "order2")
    //单曲循环
    let order3 = UIImage(named: "order3")
    //给按钮添加一个监听事件
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(OrderButton.onCilck(_:)), forControlEvents: .TouchUpInside)
    }
    
    
    func onCilck(sender:UIButton){
        order += 1
        if order == 1 {
            self.setImage(order1, forState: .Normal)
        } else   if order == 2 {
            self.setImage(order2, forState: .Normal)
        }  else  if order == 3 {
            self.setImage(order3, forState: .Normal)
        } else if order > 3 {
            order = 1
            self.setImage(order1, forState: .Normal)
        }
    }
}
