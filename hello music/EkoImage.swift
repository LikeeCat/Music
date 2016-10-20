//
//  EkoImage.swift
//  hello music
//
//  Created by 樊树康 on 16/7/24.
//  Copyright © 2016年 樊树康. All rights reserved.
//

import UIKit

class EkoImage: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //设置圆角
        self.clipsToBounds = true
        
        self.layer.cornerRadius = self.frame.size.width/2
        
       
        
    }
      //旋转
    func onRotation( ){
        //动画实例关键字
        let animation = CABasicAnimation(keyPath: "transform.rotation")
    
       //初始值
        
        animation.fromValue = 0.0
        
        animation.toValue = M_PI*2
        
        animation.duration = 20
        
        animation.repeatCount = 1000
        
        self.layer.addAnimation(animation, forKey: nil)
    }
    

}
