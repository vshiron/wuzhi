//
//  UserAccount.swift
//  wuzhi
//
//  Created by vshiron on 16/10/12.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit

class UserAccount: NSObject , NSCoding {


    
    //用户email
    var email :String?
    
    //用户id
    var id:String?
    
    //用户token
    var token:String?
    
    //用户密码
    var password:String?
    
    
    override init() {
        
    }
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    func setValue(value: AnyObject?, forUndefinedKey key: String) {

        
    }
    /**
     返回用户是否登录
     */
    class func userLogin() -> Bool
    {
        return UserAccount.loadAccount() != nil
    }
    
    /**
     保存授权模型
     */
    static let filePath = "account.plist".cacheDir()
    func saveAccount()
    {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    /// 加载授权模型
    static var account: UserAccount?
    class func loadAccount() -> UserAccount? {
        
        if let  account =  NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserAccount{
            
            return account
        }else{
            
            return nil
        }
    }
    
    /**
     移除登录信息
     */
    class func removeAccount(){
        let fileManager = FileManager()
        do{
            try fileManager.removeItem(atPath: "account.plist".cacheDir())
            
        }catch{
            print(error)
        }
        
    }
    
    // MARK: - NSCoding
    // 将对象写入到文件中
//    func encodeWithCoder(aCoder: NSCoder)
//    {
//        
//    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "account")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(password, forKey: "password")

    }
    
    // 从文件中读取对象
    required init?(coder aDecoder: NSCoder)
    {
        email = aDecoder.decodeObject(forKey: "account") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
    }


}

extension String{
    /**
     将当前字符串拼接到cache目录后面
     */
    func cacheDir() -> String{
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到doc目录后面
     */
    func docDir() -> String
    {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!  as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
    /**
     将当前字符串拼接到tmp目录后面
     */
    func tmpDir() -> String
    {
        let path = NSTemporaryDirectory() as NSString
        return path.appendingPathComponent((self as NSString).lastPathComponent)
    }
}
