//
//  UserModel.swift
//  wuzhi
//
//  Created by vshiron on 16/10/13.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class UserModel: BaseModel {
    /*
     1.头像
     2.名字
     3.签名
     4.日期
     5.内容与时间model
     7.小红花
     */
    
    var userImage:String?
    var name :String?
    var signature:String?
    var date:String?
    var flower:String?
    var contentModels:[contentModel]?
    
    
    

}

class contentModel: BaseModel {
    var time:String?
    var content:String?
}
