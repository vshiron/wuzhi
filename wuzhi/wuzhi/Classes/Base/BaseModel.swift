//
//  BaseModel.swift
//  wuzhi
//
//  Created by vshiron on 16/10/13.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    init(dict : [String: AnyObject] ){
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //        print(key)
    }
}
