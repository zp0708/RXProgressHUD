//
//  RXHUD.swift
//  RXProgressHUD
//
//  Created by ZP on 16/3/18.
//  Copyright © 2016年 rongtonghuixin. All rights reserved.
//

import UIKit

private let hud_duration : NSTimeInterval = 1.0

protocol RXHUDHelperHandle {
    static func show(anim:Bool, duration: NSTimeInterval,delay: NSTimeInterval,content: HUDContentType)
    static func hide(duration: NSTimeInterval, delay:NSTimeInterval, completion: (Bool -> Void)?)
    static func flash(content: HUDContentType, delay: NSTimeInterval, completion: (Bool -> Void)?)
}

public enum HUDContentType {
    case Success
    case Error
    case Progress
    case Image(UIImage?)
    case RotatingImage(UIImage?)
    
    case LabeledSuccess(title: String!, subtitle: String!)
    case LabeledError(title: String!, subtitle: String!)
    case LabeledProgress(title: String!, subtitle: String!)
    case LabeledImage(image: UIImage!, title: String!, subtitle: String!)
    case LabeledRotatingImage(image: UIImage!, title: String!, subtitle: String!)
    
    case Label(String!)
    case SystemActivity
}

public final class HUD : RXHUDHelperHandle{
    
    class func contentView(content: HUDContentType) -> UIView {
        RXHUDHelper.sharedHUD.hideWithoutAnimation()
        switch content {
        case .Success:
            return RXHUDSuccessView()
        case .Error:
            return RXHUDErrorView()
        case .Progress():
            return RXHUDProgressView()
        case let .Image(image):
            return RXHUDSquareBaseView(image: image)
        case let .RotatingImage(image):
            return RXHUDRotatingImageView(image: image)
        case let .LabeledSuccess(title, subtitle):
            return RXHUDSuccessView(title: title, subtitle: subtitle)
        case let .Label(text):
            return RXHUDTextView(text: text)
        case .SystemActivity:
            return RXHUDSystemActivityIndicatorView()
        case let .LabeledError(title, subtitle):
            return RXHUDErrorView(title: title, subtitle: subtitle)
        case let .LabeledProgress(title, subtitle):
            return RXHUDProgressView(title: title, subtitle: subtitle)
        case let .LabeledImage(image, title, subtitle):
            return RXHUDSquareBaseView(image: image, title: title, subtitle: subtitle)
        case let .LabeledRotatingImage(image, title, subtitle):
            return RXHUDRotatingImageView(image: image, title: title, subtitle: subtitle)
        }
    }

    // when the duration is 0.0 ,show will without animation
    static func show(anim:Bool, duration: NSTimeInterval,delay: NSTimeInterval,content: HUDContentType) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show(autoDimiss: false, anim: anim, delayTime: delay)
    }
    
    static func hide(duration: NSTimeInterval, delay:NSTimeInterval, completion: (Bool -> Void)?) {
        RXHUDHelper.sharedHUD.hideWithDelay(delay, completion: completion)
    }
    
    static func flash(content: HUDContentType, delay: NSTimeInterval, completion: (Bool -> Void)?) {
        HUD.show(content)
        HUD.hide(hud_duration, completion: completion)
    }
}

// MARK: >>>>>>>>>> with completion <<<<<<<<<<
extension RXHUDHelperHandle {
    
}

// MARK: >>>>>>>>>> flash extension <<<<<<<<<<
extension RXHUDHelperHandle {
    static func flash(content: HUDContentType) {
        HUD.show(content)
        HUD.hide(hud_duration, completion: nil)
    }
}

// MARK: >>>>>>>>>> show extension (window) <<<<<<<<<<
extension RXHUDHelperHandle {
    static func show(content: HUDContentType) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show()
    }
    
    static func show(delay: NSTimeInterval,content: HUDContentType) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show(autoDimiss: true, anim: true,delayTime: delay)
    }
    
    static func showText(text: String) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Label(text))
        RXHUDHelper.sharedHUD.show(autoDimiss: true, anim: true, delayTime: hud_duration)
    }
    
    static func showSuccess(){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Success)
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
    
    static func showSuccess(status:String){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledSuccess(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
    
    static func showError(){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Error)
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
    
    static func showError(status:String){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledError(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
}

// MARK: >>>>>>>>>> show extension (view) <<<<<<<<<<

extension RXHUDHelperHandle {
    static func showWithView(view: UIView,content: HUDContentType, anim:Bool) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: anim)
    }
    
    static func showSuccessWithView(view: UIView, anim:Bool){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Success)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: anim)
    }
    
    static func showSuccessWithView(view: UIView,status:String, anim:Bool){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledSuccess(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: anim)
    }
    
    static func showErrorWithView(view: UIView, anim:Bool){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Error)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: anim)
    }
    
    static func showErrorWithView(view: UIView,status:String, anim:Bool){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledError(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: anim)
    }
    
    static func showWithView(view: UIView,content: HUDContentType) {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(content)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: true)
    }
    
    static func showSuccessWithView(view: UIView){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Success)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: true)
    }
    
    static func showSuccessWithView(view: UIView,status:String){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledSuccess(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: true)
    }
    
    static func showErrorWithView(view: UIView){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Error)
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: true)
    }
    
    static func showErrorWithView(view: UIView,status:String){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.LabeledError(title: "", subtitle: status))
        RXHUDHelper.sharedHUD.show(forView: view,dismiss: true, anim: true)
    }
}

// MARK: >>>>>>>>>> didden extension <<<<<<<<<<
extension RXHUDHelperHandle {
    
    static func hidden() {
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration, completion: nil)
    }
    
    static func hide(completion: (Bool -> Void)? = nil) {
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration, completion: completion)
    }
    
    static func hide(delay:NSTimeInterval, completion: (Bool -> Void)? = nil) {
        RXHUDHelper.sharedHUD.hideWithDelay(delay, completion: completion)
    }
    
    static func hideWithSuccess() {
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Success)
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
    
    static func hideWithError(){
        RXHUDHelper.sharedHUD.contentView = HUD.contentView(.Error)
        RXHUDHelper.sharedHUD.show()
        RXHUDHelper.sharedHUD.hideWithDelay(hud_duration)
    }
}

public class RXHUDHelper: NSObject {
    var showDuration : NSTimeInterval = 0.15
    var centerOffset : Float = 10.0
    var hudRadius : Float = 9.0 {
        willSet {
            frameView.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    var style : UIBlurEffectStyle = .Light {
        willSet {
            frameView.removeFromSuperview()
            frameView = FrameView(style: newValue)
        }
    }
    
    var strokeColor :UIColor {
        get {
            return self.style == .Light ? UIColor.blackColor() : UIColor.whiteColor()
        }
        set {
            self.strokeColor = newValue
        }
    }
    
    private struct Constants {
        static let sharedHUD = RXHUDHelper()
    }
    
    public class var sharedHUD: RXHUDHelper {
        return Constants.sharedHUD
    }
    
    private var hideTimer: NSTimer?
    var frameView = FrameView(style: .Light)
    public typealias CompletedAction = (finished: Bool) -> (Void)
    var isVisiable = true
    
    public weak var contentView: UIView? {
        get {
            return self.frameView.content
        }
        set {
            self.frameView.content = newValue!
            startAnimatingContentView()
        }
    }

    public override init () {
        super.init()
    
    }
    
    // MARK: >>>>>>>>>> show methods <<<<<<<<<<
    
    public func show(forView view: UIView,anim: Bool) {
        isVisiable = false
        show(view, autoDismiss: false,anim: anim, delayTime: 0.0)
    }
    
    public func show(forView view: UIView,dismiss: Bool,anim: Bool) {
        isVisiable = false
        show(view, autoDismiss: dismiss,anim: anim, delayTime: 0.5)
    }
    
    public func show() {
        show(autoDimiss: false,anim: true, delayTime: 0.0)
    }
    
    public func show(autoDimiss dismiss:Bool,anim: Bool,delayTime: NSTimeInterval) {
        isVisiable = false
        if let window = UIApplication.sharedApplication().keyWindow {
            show(window, autoDismiss: dismiss,anim: true, delayTime: delayTime)
        }
    }
    
    var cancell : CancelableTask = delay(0) {}!
    
    private func show(view: UIView,autoDismiss dismiss:Bool,anim:Bool,delayTime:NSTimeInterval) {
        view.addSubview(frameView)
        frameView.center = view.center
        frameView.center.y -= CGFloat(centerOffset)
        UIView.animateWithDuration(showDuration, animations: { () -> Void in
            self.frameView.alpha = 1.0
            }) { (finish) -> Void in
        }
        if anim{self.startAnimatingContentView()}
        guard dismiss == false else {
            cancel(self.cancell)
            
            self.cancell = delay(delayTime) {[weak self] () -> Void in
                self!.hide(delayTime,duration: 0.35,completed:nil)
            }!
            
            return
        }
    }
    
    // MARK: >>>>>>>>>> hide methods <<<<<<<<<<
    
    public func hide(){
        hide(0, duration: 0.35, completed: nil)
    }

    public func hide(delay: NSTimeInterval, duration: NSTimeInterval,completed: CompletedAction?) {
        UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: { [weak self] () -> Void in
            self!.frameView.alpha = 0.0
            }) {[weak self] (finish) -> Void in
                if finish {
                    if let completion = completed {completion(finished: finish)}
                    self!.stopAnimatingContentView()
                    self!.frameView.removeFromSuperview()
                    self!.isVisiable = true
                }
        }
    }
    
    public func hideWithDelay(delay: NSTimeInterval, completion: CompletedAction? = nil) {
        hide(delay, duration: 0.35, completed: completion)
    }
    
    public func hideWithoutAnimation() {
        self.stopAnimatingContentView()
        self.frameView.removeFromSuperview()
        self.isVisiable = true
        frameView.layer.removeAllAnimations()
    }
    
    internal func startAnimatingContentView() {
        if isVisiable == false && contentView!.respondsToSelector("startAnimation") {
            let animatingContentView = contentView as! RXHUDAnimating
            animatingContentView.startAnimation()
        }
    }
    
    internal func stopAnimatingContentView() {
        if isVisiable == false && contentView!.respondsToSelector("stopAnimation"){
            let animatingContentView = contentView as! RXHUDAnimating
            animatingContentView.stopAnimation()
        }
    }
}

internal class FrameView: UIVisualEffectView {
    
    internal init(style: UIBlurEffectStyle) {
        super.init(effect: UIBlurEffect(style: style))
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 9.0
        layer.masksToBounds = true
        contentView.addSubview(self.content)

        let offset = 20.0
        
        let motionEffectsX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        motionEffectsX.maximumRelativeValue = offset
        motionEffectsX.minimumRelativeValue = -offset
        
        let motionEffectsY = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
        motionEffectsY.maximumRelativeValue = offset
        motionEffectsY.minimumRelativeValue = -offset
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [motionEffectsX, motionEffectsY]
        
        addMotionEffect(group)
    }
    
    private var _content = UIView()
    internal var content: UIView {
        get {
            return _content
        }
        set {
            _content.removeFromSuperview()
            _content = newValue
            _content.alpha = 0.85
            _content.clipsToBounds = true
            _content.contentMode = .Center
            frame.size = _content.bounds.size
            addSubview(_content)
        }
    }
    deinit{
        print("FrameView:)")
    }
}

typealias CancelableTask = (cancel: Bool) -> Void

func delay(time: NSTimeInterval, work: dispatch_block_t) -> CancelableTask? {
    var finalTask: CancelableTask?
    let cancelableTask: CancelableTask = { cancel in
        if cancel {
            finalTask = nil // key
        } else {
            dispatch_async(dispatch_get_main_queue(), work)
        }
    }
    finalTask = cancelableTask
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
        if let task = finalTask {
            task(cancel: false)
        }
    }
    return finalTask
}

func cancel(cancelableTask: CancelableTask?) {
    cancelableTask?(cancel: true)
}
