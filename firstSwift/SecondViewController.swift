//
//  SecondViewController.swift
//  firstSwift
//
//  Created by 朱大茂 on 14-10-28.
//  Copyright (c) 2014年 zhudm. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let urlApi = "http://qingbin.sinaapp.com/api/lists?ntype=%E5%9B%BE%E7%89%87&pageNo=1&pagePer=10&list.htm"
    var dataArry = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshContrl = UIRefreshControl()
        refreshContrl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshContrl.addTarget(self, action: "loadData", forControlEvents: UIControlEvents.ValueChanged)
        
        
//        let url = NSURL(string: self.urlApi)
//        let request = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
//        var respone:NSURLResponse?
//        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &respone, error: nil)
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        
        self.loadData()
    }
    
    func loadData(){
        let url = NSURL(string: self.urlApi)
        let request = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
         var respone:NSURLResponse?
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var respone:NSURLResponse?
            var error:NSError?
            let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &respone, error: &error)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.dataArry = json["item"] as NSArray
                self.tableView.reloadData()
            })
            
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath!) -> UITableViewCellAccessoryType {
        return UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        
        let object = self.dataArry[indexPath.row] as NSDictionary
        
        cell?.textLabel.text = object["title"] as NSString
        cell?.detailTextLabel?.text = object["id"] as NSString

        let urlHead = object["thumb"] as NSString
        let headUrl = NSURL(string: urlHead)
        let requet = NSURLRequest(URL: headUrl!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var error:NSError?
            var respone:NSURLResponse?
            let data = NSURLConnection.sendSynchronousRequest(requet, returningResponse: &respone, error: &error)
            if data == nil {
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in

                var image = UIImage(data: data!)
                //image = image?.resizableImageWithCapInsets(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
                cell?.imageView.image = image
            })
        })
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArry.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
