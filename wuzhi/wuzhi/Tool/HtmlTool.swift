//
//  HtmlTool.swift
//  wuzhi
//
//  Created by vshiron on 16/10/12.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class HtmlTool: NSObject {
    

    
    
    //传入密码和账号,返回登录成功或者失败的信息
    class func requestOfLogin(email:String,password:String,success: @escaping ()->()) {
        
        var param = [String:AnyObject]()
        
        param["email"] = "vshiron@163.com" as AnyObject?
        param["password"] = "z22303580" as AnyObject?
        
        if !UserAccount.userLogin() {
            
            NetworkTools.shareNetworkTools().post("https://wuzhi.me/login", parameters: param, progress: nil, success:{(URLSessionDataTask, data)in
                
    //            let jsonStr = String.init(data: data as! Data, encoding: .utf8)!
                
                let doc = TFHpple.init(htmlData: data as! Data)
                
                //如果能进入这里的话,说明登录失败,密码错误或者其他错误
                if let arr = doc?.search(withXPathQuery: "//div[@class='err']"){
                    for element in arr {
                        
                        let a = element as! TFHppleElement;
                        
                        let title = a.content;
                        SVProgressHUD.showError(withStatus: title!)
                        return
                    }
                }
                
                
                
    //            获得token
                if let arr = doc?.search(withXPathQuery: "//input[@name='csrf_token']"){
                    print(arr.count)
                    for element in arr {
                        let a = element as! TFHppleElement;
                        
                        let token = a.object(forKey: "value")
                        
                        if let t = token {
                            param["token"] = t as AnyObject?
                        }
                        
                        
                    }
                }
                
                //获得主页id
                if let arr = doc?.search(withXPathQuery: "//div[@class='header']"){
                    
                    
                    for element in arr {
                        let upElement = element as! TFHppleElement;

                       let downElement = upElement.children![3] as! TFHppleElement
                        let endUrl = downElement.object(forKey: "href")
                        
    //                    let index = String()
                        
                        let index : String.Index = (endUrl?.index(endUrl!.startIndex, offsetBy: 3))!
                        
                        let id = endUrl!.substring(from: index)
                        param["id"] = id as AnyObject?
                    }
                }
                
                
//                let account = UserAccount.loadAccount()

//                 print(account?.email!,account?.password!,account?.token!,account?.id!)
                //成功后回调
     
                
            }, failure:{(URLSessionDataTask, error) in
                
                SVProgressHUD.showError(withStatus: "哎呦,您的网络好像有问题,请稍后再试吧")
            });

            
            
        }
    }
    

    //获取主页列表
    class func requestOfList(sucessed:@escaping ([AttentionModel]?)->()){
        if UserAccount.userLogin(){
            
            let url = "https://wuzhi.me/last"
            
            NetworkTools.shareNetworkTools().post(url, parameters: nil, progress: nil, success: { (URLSessionDataTask, data) in
//                let jsonStr = String.init(data: data as! Data, encoding: .utf8)!
                let doc = TFHpple.init(htmlData: data as! Data)
//                print(jsonStr)
                var modelArr :[AttentionModel] = []
                //获取首页的model
                if let arr = doc?.search(withXPathQuery: "//td[@class='user_avatar']"){
                    let arrb = arr as! [TFHppleElement]
                    
                    for element in arrb {
                        
                        
                        let elementArr = element.children[1] as! TFHppleElement;
                        
                        //当前节点属性
                        let userID = elementArr.object(forKey: "href")
                        
                       let childElement = elementArr.children[1] as! TFHppleElement
                        
                        let UserImage = childElement.object(forKey: "src")
                        let name = childElement.object(forKey: "alt")
                        
                        var dict:[String:AnyObject] = [:]
                        dict["userImage"] = UserImage as AnyObject?
                        dict["name"] = name as AnyObject?
                        dict["id"] = userID as AnyObject?
                        
                        let model = AttentionModel(dict: dict)
                        // 添加到数组中
                        modelArr.append(model)

                        
                    }
                    
                    sucessed(modelArr)
                    
                }
                print(modelArr.count)
//                sucessed()
                
            }, failure: { (URLSessionDataTask, error ) in
                
            })
            
        }
        
    }
    
    
    //点击头像后进入用户详细界面
    class func requestOfSingleUser(userID:String,success:@escaping (UserModel)->()){
        
        let url = "https://wuzhi.me/\(userID)"
        
        NetworkTools.shareNetworkTools().post(url, parameters: nil, progress: nil, success:{(URLSessionDataTask, data)in
            
//            let jsonStr = String.init(data: data as! Data, encoding: .utf8)!
            
            let doc = TFHpple.init(htmlData: data as! Data)
            /*
             1.头像
             2.名字
             3.签名
             4.日期
             5.内容与时间model
             7.小红花
             */
            var param:[String:AnyObject] = [:]

            
            
//            头像地址/名字
            if let arr = doc?.search(withXPathQuery: "//span[@class='img_shadow']"){
                 let arrb = arr as! [TFHppleElement]
                
                for element in arrb {
                    

                    let elementArr = element.children[1] as! TFHppleElement;
                    param["userImage"] = elementArr.object(forKey: "src") as AnyObject?
                    param["name"] = elementArr.object(forKey: "alt") as AnyObject?
                    
                }
            }

            
            
            //签名
            if let arr = doc?.search(withXPathQuery: "//span[@class='quote_text']"){
            
                for element in arr {
                    
                    let a = element as! TFHppleElement;
                    param["signature"] = a.content as AnyObject?
                    
                }
            }
            
                //日期和小红花数量
                if let arr = doc?.search(withXPathQuery: "//div[@class='date_line']"){

                    let arrb = arr as! [TFHppleElement]
                    
                    for element in arrb {
                        //获取该节点下的各个节点
                        let a = element.children
                        
                        //获得日期
                        let timeClass = a?[1] as! TFHppleElement
                        let time = timeClass.children.first as! TFHppleElement
//                        print()
                        param["date"] = time.content as AnyObject?
                        
                        //获得小红花数量
                        let flowerNumber = a?[3] as! TFHppleElement
                        let number = flowerNumber.children.last as! TFHppleElement
                        param["flower"] = number.content as AnyObject?
                        
                        
                    }
                }
            
            
            
                //当天几次的时间和内容 -->存入model
                if let arr = doc?.search(withXPathQuery: "//div[@class='note_each']"){

                    let arrb = arr as! [TFHppleElement]
                    
                    var contentModels :[contentModel] = []
                    
//                    print(arrb.count)
                    for element in arrb {
                        //获取该节点下的各个节点
                        let a = element.children
                        //获得时间
                        let timeClass = a?[1] as! TFHppleElement
                        let time = timeClass.children.first as! TFHppleElement
                        

                        //获得内容
                        let flowerNumber = a?[3] as! TFHppleElement
                        let number = flowerNumber.children.last as! TFHppleElement
                        
                        
                        let dict = ["time": time.content,"content":number.content]
                        let model = contentModel(dict: dict as [String : AnyObject])
                        contentModels.append(model)

                    }
                    
                    param["contentModels"] = contentModels as AnyObject?
                    let model = UserModel(dict: param)
                    
                    success(model)
                }
            
        }, failure:{(URLSessionDataTask, error) in
            
            SVProgressHUD.showError(withStatus: "哎呦,您的网络好像有问题,请稍后再试吧")
        });
        
    }
    
}
