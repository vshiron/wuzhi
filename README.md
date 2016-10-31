# wuzhi
### 吾志的app客户端swift3.0实现,开发中,由于所有接口都是来自于网页抓dom节点,所有目前还在调试接口

### HtmlTool
1. `requestOfLogin(email:String,password:String,success: @escaping ()->()` 类通过节点的补足,上传用户输入原生iOS端的接口转换为http请求发送到服务器,返回一个主页id,传入密码和账号,返回登录成功或者失败的信息
2. `requestOfList(sucessed:@escaping ([AttentionModel]?)->())`获取主页列表
3. `requestOfSingleUser(userID:String,success:@escaping (UserModel)->()`点击头像后进入用户详细界面,由于没有服务器返回的正式json数据,本软件的接口都是通过第三方类库TFHpple实现的.如果需要知道实现的细节,请看源代码,如果需要了解第三方库是如何实现的,请查找TFHpple的原文啦
4. NetworkTools的单例就不说了,基于AFNetworking的简单封装,还有导入了几个常用的第三方库,MJRefresh,SDWebImage,SVPorgressHUD等~