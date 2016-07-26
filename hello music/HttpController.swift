//
//  HttpController.swift
//  hello music
//
//  Created by 樊树康 on 16/7/24.
//  Copyright © 2016年 樊树康. All rights reserved.
//

import Foundation
import Alamofire

class HttpController: NSObject {
    var delegate:HttpProtocol?
    //定义一个代理
    func onSearch(url:String) {
        
        Alamofire.request(Method.GET, url).responseJSON(options: NSJSONReadingOptions.MutableContainers) { response -> Void in
            self.delegate?.didRecieveResults(response.result.value!)
        }
        }
}
//定义http协议
protocol HttpProtocol {
    //定义一个方法,接收一个参数:anyobject
    func didRecieveResults(results:AnyObject)
}

