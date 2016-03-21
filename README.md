# RXProgressHUD
###### RXProgressHUD是一个简单一用的HUD控件
###### 使用方法

###### success
<pre><code>
   HUD.showSuccessWithView(self.view, anim: false)
   HUD.showSuccess()
   HUD.showSuccess("success!")
   HUD.show(true, duration: 0.25, delay: 1, content: .LabeledSuccess(title: "title", subtitle: "subtitle"))
</code></pre>

###### error
<pre><code>
   HUD.showError()
   HUD.showError("error!")
   HUD.show(true, duration: 0.25, delay: 1, content: .LabeledError(title: "title", subtitle: "subtitle"))
</code></pre>

###### progress
<pre><code>
   HUD.show(.Progress)
   HUD.show(.SystemActivity)
</code></pre>

###### HUD的三个基本方法
<pre><code>
    static func show(anim:Bool, duration: NSTimeInterval,delay: NSTimeInterval,content: HUDContentType)
    static func hide(duration: NSTimeInterval, delay:NSTimeInterval, completion: (Bool -> Void)?)
    static func flash(content: HUDContentType, delay: NSTimeInterval, completion: (Bool -> Void)?)
</code></pre>
   
###### 拓展的方法
<pre><code>

// MARK: >>>>>>>>>> flash extension <<<<<<<<<<
extension RXHUDHelperHandle {
    static func flash(content: HUDContentType) {
        HUD.show(content)
        HUD.hide(hud_duration, completion: nil)
    }
}

// MARK: >>>>>>>>>> show extension (window) <<<<<<<<<<
extension RXHUDHelperHandle {
    static func show(content: HUDContentType) 
    static func show(delay: NSTimeInterval,content: HUDContentType) 
    static func showText(text: String)
    static func showSuccess()
    static func showSuccess(status:String)
    static func showError()
    static func showError(status:String)
}

// MARK: >>>>>>>>>> show extension (view) <<<<<<<<<<

extension RXHUDHelperHandle {
    static func showWithView(view: UIView,content: HUDContentType, anim:Bool)
    static func showSuccessWithView(view: UIView, anim:Bool)
    static func showSuccessWithView(view: UIView,status:String, anim:Bool)
    static func showErrorWithView(view: UIView, anim:Bool)
    static func showErrorWithView(view: UIView,status:String, anim:Bool)
    static func showWithView(view: UIView,content: HUDContentType)
    static func showSuccessWithView(view: UIView)
    static func showSuccessWithView(view: UIView,status:String)
    static func showErrorWithView(view: UIView)
    static func showErrorWithView(view: UIView,status:String)
}

// MARK: >>>>>>>>>> hidden extension <<<<<<<<<<
extension RXHUDHelperHandle {
    static func hidden() 
    static func hide(completion: (Bool -> Void)? = nil) 
    static func hide(delay:NSTimeInterval, completion: (Bool -> Void)? = nil) 
    static func hideWithSuccess()
    static func hideWithError()
}
</code></pre>

###### 通过下面的一些设置可以自定义一些HUD的样式
<pre><code>
# HUD一共有Dark和Light两种风格
  RXHUDHelper.sharedHUD.style = .Dark 
# 设置HUD的圆角
  RXHUDHelper.sharedHUD.hudRadius = 0
# 设置HUD的显示时动画时间
  RXHUDHelper.sharedHUD.showDuration = 1
# 设置HUD距离屏幕中心或者view中心的偏移量
  RXHUDHelper.sharedHUD.centerOffset = 50
</code></pre>


###### 你可以通过对RXHUDHelperHandle协议进行拓展来获得自己需要的方法
<pre><code>
extension RXHUDHelperHandle {
    static func show(content: HUDContentType) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show()
    }
}
</code></pre>

###### notice
RXProgressHUD是我学习Swift时的一个练习项目，该项目是参考了:[PKHUD](https://github.com/pkluz/PKHUD) 


![](https://github.com/NewUnsigned/RXProgressHUD/blob/master/RXProgressHUD/2016-03-21%2013_09_16.gif)
![](https://github.com/NewUnsigned/RXProgressHUD/blob/master/RXProgressHUD/2016-03-21%2013_14_28.gif)

