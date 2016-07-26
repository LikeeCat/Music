//
//  EkoButton.swift
//  hello music
//
//  Created by 樊树康 on 16/7/25.
//  Copyright © 2016年 樊树康. All rights reserved.
//

//import UIKit
//
//class EkoButton:UIButton {
//    var isPlay = true
//    
//    let imgPlay = UIImage(named: "play")
//    
//    let imgpause = UIImage(named: "isplay")
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.addTarget(self, action: #selector(EkoButton.onClick), forControlEvents: .TouchUpInside)
//        
//    }
//    
//    func onClick()  {
//        isPlay = !isPlay
//        //如果还没有播放 而其实按钮显示的是已经播放,当你点击按钮的时候,这个时候歌曲开始播放而按钮状态显示的是暂停
//        if isPlay {
//            self.setImage(imgpause, forState: .Normal)
//        }
//        else{
//            self.setImage(imgPlay, forState: .Normal)
//        }
//    }
//    func onPlay() {
//        isPlay = true
//        self.setImage(imgpause, forState: .Normal)
//    }
//}


import UIKit

class EkoButton: UIButton {
    var isPlay = true
    let imgPlay = UIImage(named: "play")
    let imgPause = UIImage(named: "pause")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(EkoButton.onClick), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    func onClick(){
        isPlay = !isPlay
        if isPlay {
            self.setImage(imgPause, forState: UIControlState.Normal)
            
        }else{
            self.setImage(imgPlay, forState: UIControlState.Normal)
        }
    }
    
    func onPlay(){
        isPlay = true
        self.setImage(imgPause, forState: UIControlState.Normal)
    }
}
