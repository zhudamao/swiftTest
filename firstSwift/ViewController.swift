//
//  ViewController.swift
//  firstSwift
//
//  Created by 朱大茂 on 14-10-20.
//  Copyright (c) 2014年 zhudm. All rights reserved.
//

import UIKit

@objc protocol MySwiftDelegate:NSObjectProtocol{
    optional func getAge() ->Int
}


class ViewController: UIViewController{

    @IBOutlet var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var button = UIButton()
        button.backgroundColor = UIColor.redColor()
        var width = UIScreen.mainScreen().bounds.width
        button.frame = CGRectMake(0, 64, width, 40)
        button.addTarget(self, action: "goNext:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(button)
        
        nextButton.setTitle("push", forState: UIControlState.Normal)
        
        nextButton.addTarget(self, action: "goNext:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let myconstant:Int = 42

        let myTitle = "Title\(myconstant)"
        button.setTitle(myTitle, forState: UIControlState.Normal)
        
        println(myTitle.lastPathComponent)
        
        var shopList:Array = [1,2,3]
        println(shopList.count)
        shopList[1] = 7
        println(shopList)
        
        for(index,value) in enumerate(shopList){
            println("Item \(index) :\(value)")
        }
        
        
        var dic = Dictionary<String,Float>()
        dic["me"] = 0.01
        
        let tempDic = ["one":1,"two":2]
        
        var tDic:Dictionary<Int,String> = [:];
        
        for(index,value) in enumerate(tempDic){
            println("Item \(index) :\(value)")
        }
    
        let tumple = getTumple(10, name: "zhu")
        println(tumple.0,tumple.1)
        
        
        let lable = UILabel(frame: CGRect(x: 0, y: 104, width:UIScreen.mainScreen().bounds.width, height: 40))
        lable.backgroundColor = UIColor.blueColor()
        lable.textAlignment = NSTextAlignment.Center
        lable.text = "I am Lable"
        
        self.view.addSubview(lable)
        
        let addOne = testForCatch()
        println(addOne())
        println(addOne())
        
        for i in 0 ... 3{ // 两个点 废掉了
            println(i)
        }
        
        self.showName(s1:"")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController;
        segue.sourceViewController;
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTumple(age:Int,name:String)->(Int,String){
        return (age,name)
    }

    
    
    func goNext(sender:UIButton?){
        self.performSegueWithIdentifier("sbhh", sender: sender)
    }

    func showName( s1:String = "ad"){
        println(s1)
    }
    
    func testForCatch()->(() -> Int){
        var num = 0;
        
        func tempCathch() -> Int{
             num += 1
            return num
        }
    
        return tempCathch
    }
    
}

