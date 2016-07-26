//
//  ChannelViewController.swift
//  hello music
//
//  Created by 樊树康 on 16/7/24.
//  Copyright © 2016年 樊树康. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol ChannelProtocol {
    func onChangeChannel(channel_id:String)
}

class ChannelViewController: UIViewController,UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    
    
    //声明代理
    var delegate:ChannelProtocol?
    
    //建立一个频道数组
    var channelData :[JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
     print(channelData.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
 
      
        // Dispose of any resources that can be recreated.
    }
    
  // 配置数据源函数
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelData.count
    }
   // 设置tableview的数据行数
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channel")! as UITableViewCell
        //获取行数据
        let rowData:JSON = self.channelData[indexPath.row] as JSON
        //设置单元格标题
        cell.textLabel?.text = rowData["name"].string
        
        
        return cell
    }
    //选中单元格用的时didSelectRowAtIndexPath
    //反选单元格用的是didDeselectRowAtIndexPath
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //获取当前的选择行
        let rowData = self.channelData[indexPath.row] as JSON
        //获取选中行的id
        let channel_id = rowData["channel_id"].stringValue
        //将频道id反向传给主界面
        delegate?.onChangeChannel(channel_id)
        
        //关闭当前界面
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //设置cell的显示动画
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //设置cell的显示动画为3d缩放,xy方向的缩放动画,初始值为0.1,结束值为1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.3) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        
    }
    
    

}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


