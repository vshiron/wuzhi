//
//  NetworkTools.swift
//  IndustryTemplate
//
//  Created by vshiron on 16/4/1.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class NetworkTools: AFHTTPSessionManager {

    static let tools: NetworkTools = {
        
        let tool = NetworkTools()
        
        //设置类型
        tool.responseSerializer.acceptableContentTypes =  NSSet(objects: "application/json", "text/html","text/json", "text/javascript", "text/plain","image/png") as? Set<String>

        tool.responseSerializer = AFHTTPResponseSerializer()
        
        return tool
    }()
    
    //获取单例
    class func shareNetworkTools() ->NetworkTools{
        return tools
    }
    
    
}
