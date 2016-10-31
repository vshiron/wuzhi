//
//  BaseTabBarController.swift
//  wuzhi
//
//  Created by vshiron on 16/10/9.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpChildController(AttentionViewController(), title: "发现", image: "", selectedImage: "")
        setUpChildController(DiscoverViewController(), title: "关注", image: "", selectedImage: "")
        
        
        setUpChildController(WriteViewController(), title: "写日记", image: "", selectedImage: "")
        
        
        setUpChildController(MyViewController(), title: "我的", image: "", selectedImage: "")
        

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    fileprivate func setUpChildController(_ ChildViewContronller:UIViewController,title:String,image:String,selectedImage:String){
        ChildViewContronller.title = title;
        ChildViewContronller.tabBarItem.image = UIImage(named: image)
        ChildViewContronller.tabBarItem.image = UIImage(named: selectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        var textAttrs:[String:AnyObject] = [:] ;
        textAttrs[NSForegroundColorAttributeName] = UIColor.red
        var seletedAttrs :[String:AnyObject] = [:] ;
        seletedAttrs[NSForegroundColorAttributeName] = UIColor.blue
        
        ChildViewContronller.tabBarItem.setTitleTextAttributes(textAttrs, for: UIControlState())
        ChildViewContronller.tabBarItem.setTitleTextAttributes(seletedAttrs, for: UIControlState.selected)
        let nav = BaseNavigationController(rootViewController: ChildViewContronller)
        self.addChildViewController(nav)
        
    }

}
