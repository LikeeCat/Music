//
//  ViewController.swift
//  hello music
//
//  Created by 樊树康 on 16/7/23.
//  Copyright © 2016年 樊树康. All rights reserved.
//
import UIKit
import SwiftyJSON
import Alamofire
import MediaPlayer
class ViewController: UIViewController ,HttpProtocol,ChannelProtocol,UITableViewDelegate{
    


   var audioplayer = MPMoviePlayerController()


    var isAutoFinsh = true
    
    //声明一个计时器
    var time :NSTimer!
    //网络操作类的实例
    var eHTTP = HttpController()
    //定义一个变量,接受频道的歌曲频道
    var tableData:[JSON] = []
    
    //定义一个变量,接收歌曲的数据
    var channelData:[JSON] = []

    //定义一个变量,定义歌曲名称
    //定义一个字典
   var imageCache = Dictionary <String ,UIImage>()
    
    //当前播放第几首歌曲
    
    var currIndex = 0
    
   
//    @IBAction func play(sender: AnyObject) {
//        
//        if isplaying{
//            audioplayer.pause()
//            isplaying = false
//            buttonImg.setImage(UIImage(named: "play"), forState: .Normal)
//            
//            //取消动画
//            spinImg.layer.removeAllAnimations()
//        }
//        else {
//            audioplayer.play()
//            
//             time = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self , selector: "updatetime", userInfo: nil, repeats: true)
//            buttonImg.setImage(UIImage(named: "isplay"), forState: .Normal)
//            
//            spinImg.onRotation()
//            timeBg.onRotation()
// 
//            
//            isplaying = true
//        }
//        
// 
//    }
//@IBAction func reset(sender: AnyObject) {
//    
//    audioplayer.stop()
//    
//    audioplayer.currentTime = 0
//    
//    isplaying = false
//    
//    
//    
//}


    @IBOutlet weak var progressView: UIProgressView!
//    播放时间显示控件
    @IBOutlet weak var duartion: UILabel!
    @IBOutlet weak var playTime: UILabel!
   
    //EkoImag的组件,歌曲进度
    @IBOutlet weak var timeBg: EkoImage!
   
    //EkoImag的组件,歌曲封面
    @IBOutlet weak var spinImg: EkoImage!
    //视图的背景
    @IBOutlet weak var background: UIImageView!
    //歌曲名称
    @IBOutlet weak var tittle: UILabel!

   //视图的列表视图
  
    @IBOutlet weak var tableView: UITableView!
   //下一首按钮
    @IBOutlet weak var btnNext: UIButton!
  
    //播放按钮
    @IBOutlet weak var btnPlay: EkoButton!
    
    //上一首按钮
    @IBOutlet weak var btnPre: UIButton!
    
    //设置循环模式
    
    

    @IBOutlet weak var btnOrder: OrderButton!
    override func viewDidLoad() {
        super.viewDidLoad()
      //为网络操作类设置代理 
        tableView.backgroundColor = UIColor.clearColor()
        
        eHTTP.delegate = self
       //获取频道数据
        eHTTP.onSearch("http://www.douban.com/j/app/radio/channels")
        eHTTP.onSearch("http://douban.fm/j/mine/playlist?type=n&channel=0&from=mainsite")
        //高斯模糊特效
        
        let mohu = UIVisualEffectView(effect:(UIBlurEffect(style:.Light)))
        
        mohu.frame = view.frame
      
        background.addSubview(mohu)
        
        //单元格行数自适应
        
        tableView.estimatedRowHeight = 80
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.playFinish)" MPMoviePlayerPlaybackDidFinishNotification, object: audioplayer)
        //播放结束通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.playFinish), name: MPMoviePlayerPlaybackDidFinishNotification, object: audioplayer)
        

//        tittle.text = "天行九歌"
//        
//        let path = NSBundle.mainBundle().URLForResource("天行九歌", withExtension:"mp3" )
//        
//        _ = NSError?()
//      
//        
//        do{
//            audioplayer = try  AVAudioPlayer(contentsOfURL: path!)}
//        catch{
//  
//        }
//       

        //监听按钮
        btnPlay.addTarget(self, action: #selector(ViewController.onPlay(_:)), forControlEvents: .TouchUpInside)
        btnPre.addTarget(self, action: #selector(ViewController.onClick(_:)), forControlEvents: .TouchUpInside)
        btnNext.addTarget(self, action: #selector(ViewController.onClick(_:)), forControlEvents: .TouchUpInside)
        btnOrder.addTarget(self, action: #selector(ViewController.onOrder(_:)), forControlEvents: .TouchUpInside)

        
    }
    
    func onOrder(btn:OrderButton){
        var message = ""
      
        
        switch (btn.order) {
        case 1:
            message = "顺序播放"
       
           
        case 2:
            message = "随机播放"
        case 3:
            message = "单曲循环"
        default:
            break
       
        }
      
        print(message)
    }
  
    //认为结束的三种情况 1 点击上一首 下一首 2 选择了频道列表的时候 3 点击了歌曲列表的某一行的时候
//    func playFinish() {
//        
//        if self.isAutoFinsh{
//        switch (btnOrder.order) {
//        case 1:
//            currIndex += 1
//            if currIndex > tableData.count - 1 {
//                currIndex = 0
//            }
//            onSelectRow(currIndex)
//            print("顺序播放\(currIndex)")
//        case 2:
//            currIndex = random() % tableData.count
//            print("随机播放\(currIndex)")
//            onSelectRow(currIndex)
//        case 3:
//            print("单曲训话啊\(currIndex)")
//            onSelectRow(currIndex)
//        default:
//           break
//    
//        }
//        }else{
//            isAutoFinsh = true
//        }
//    }
    func playFinish(){
        if self.isAutoFinsh{
            switch(btnOrder.order){
            case 1:
                currIndex += 1
                if currIndex > tableData.count - 1 {
                    currIndex = 0
                }
                onSelectRow(currIndex)
            case 2:
               // currIndex = random() % tableData.count
                currIndex = Int (arc4random())
                currIndex = currIndex % tableData.count
                onSelectRow(currIndex)
            case 3:
                onSelectRow(currIndex)
            default:
                "default"
            }
        }else{
            isAutoFinsh = true
        }
    }
    func onClick(btn:UIButton){
        
        isAutoFinsh = false
        if btn == btnNext{
            currIndex = currIndex + 1
            if currIndex > self.tableData.count - 1{
                currIndex = 0
            }
        }
        else{
            
            currIndex = currIndex - 1
            if currIndex < 0 {
                currIndex = self.tableData.count - 1
            }
        }
        onSelectRow(currIndex)
        isAutoFinsh = false
    }
    
    func onPlay(btn:EkoButton){
        if btn.isPlay{
            audioplayer.play()
            spinImg.onRotation()
            
        }else{
            audioplayer.pause()
            spinImg.layer.removeAllAnimations()
        }
    }
    
    
    //返回的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    //设置tableview的数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("douban")!
            as! ListTableViewCell
       cell.backgroundColor = UIColor.clearColor()
    
        //获取每一行的数据
        let rowData:JSON = tableData[indexPath.row]
        
        //设置单元格标题
        cell.musicName.text = rowData["albumtitle"].string
        
        
        cell.artist.text = rowData["artist"].string
       
        let url = rowData["picture"].string
        
        Alamofire.request(Method.GET,url!).response { (_, _, data, error) in
            let img = UIImage(data: data! )
            cell.img.image = img
        }
        
     
       
        return cell
    }
  //音乐播放
    
    
    func onSetAudio( url:String){
     
        
        self.audioplayer.stop()
        
      self.audioplayer.stop()

    audioplayer.contentURL = NSURL(string: url)
    
        self.audioplayer.play()
        btnPlay.onPlay()

        //计时器归0
        playTime.text = "00:00"
        
         time = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self , selector: #selector(ViewController.updatetime), userInfo: nil, repeats: true)
        isAutoFinsh = true
        spinImg.onRotation()
        
        timeBg.onRotation()
        
        
    }
    
    //设置cell的显示动画
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //设置cell的显示动画为3d缩放,xy方向的缩放动画,初始值为0.1,结束值为1
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.3) { 
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
        
    }
    
    func updatetime()  {
      //得到歌曲的总时长
          let c = audioplayer.currentPlaybackTime
       
       if c>0.0 {
            let t = audioplayer.duration
            //计算百分比
            let progress = CFloat(c/t)
        
            progressView.setProgress(progress, animated: true)
            
            //时间格式的转换
            let all = Int(c)
            //求余 得到的就是秒数
            let second = all % 60
            //求整除的结果 int类型
            let minute = all/60
                    
         let dur = Int(t)
                    
        let dminute = dur / 60
                    
        let dsecond = dur % 60
                    
        duartion.text = NSString(format: "%02d:%02d", dminute,dsecond) as String!
        playTime.text = NSString(format: "%02d:%02d",minute,second)as String!
          
        }
        
//        //歌曲的时长
//        let 时长 = audioplayer.duration
//        let time = Int(audioplayer.duration)
//        let dMinutes = time/60
//        let dSeconds = time - dMinutes*60
//        
//        print("%d",time)
//        
//        duartion.text = NSString(format: "%02d:%02d", dMinutes,dSeconds)as String!
//        //现在播放的时长
//        let 现在 = audioplayer.currentTime
//        let currentTime = Int(audioplayer.currentTime)
//       
//        let minutes = currentTime/60
//        let seconds = currentTime - minutes*60
//
//        playtime.text = NSString(format: "%02d:%02d",minutes,seconds)as String!
//        playTime.text = NSString(format: "%02d:%02d",minutes,seconds)as String!
//      
//        progress = CFloat(现在/时长)
//        print("%f",progress)
//        
//        progressView.setProgress(progress, animated: true)
//     

        
    }
    
    func didRecieveResults(results: AnyObject) {
             print("\(results)")
        let json = JSON(results)
        
        
        
        //判断是否是频道属性
        if let channels = json["channels"].array{
            self.channelData = channels
         }
        else if let song = json["song"].array{
            isAutoFinsh = false
            self.tableData = song
            
            self.tableView.reloadData()
 
            onSelectRow(0)
            
        }
        
    }
    //选中了哪一行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        isAutoFinsh = false
        onSelectRow(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       
         }
    //自定义单元格的相应方法
    func onSelectRow(index: Int){
        //构建一个indexPath
        _ = NSIndexPath(forRow: index, inSection: 0)
 
                //获取行数据
        var rowData = self.tableData[index] as JSON

        tittle.text = rowData["title"].string
        //获取该行的图片
        let imgUrl = rowData["picture"].string
          onSetImg(imgUrl!)
        
        let url = rowData["url"].string
        
         let a = rowData["sha256"].string
        print(a)
        
      onSetAudio(url!)
        
    
    }
    
    //设置歌曲封面及背景
    func onSetImg(url:String){
        Alamofire.request(Method.GET, url).response { (_
            , _, data, error) in
            //将获取的数据赋值给单元格的img
            let img = UIImage(data: data!)
            
            self.background.image = img
            
            self.spinImg.image = img
        }
    }
    func onGetCacheImage(url:String,var imageCache:UIImage)  {
        //通过图片地址去缓存中存图片
        let img = self.imageCache[url] as UIImage?
        //判断缓存中是否有这张图片
        if img == nil{
           //通过网络请求获取这张图片
            Alamofire.request(Method.GET, url).response(completionHandler: { (_, _, data, error) in
                let image = UIImage(data: data!)
                imageCache = image!
                //添加到缓存中
                self.imageCache[url] = image
            })
        }
        else {
          imageCache = img!
        }
    }
    
    //实现协议的方法
    func onChangeChannel(channel_id: String) {
        
        
        let url = "http://douban.fm/j/mine/playlist?type=n&channel=\(channel_id)&from=mainsite"
        
     eHTTP.onSearch(url)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! ChannelViewController
        
        destVC.delegate = self
        
        destVC.channelData = self.channelData
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

