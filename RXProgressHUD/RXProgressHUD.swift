//
//  RXProgressHUD.swift
//  APengDai-Swift
//
//  Created by 融通汇信 on 16/3/18.
//  Copyright © 2016年 rongtonghuixin. All rights reserved.
//

import UIKit

protocol RXHUDAnimating {
    func startAnimation()
    func stopAnimation()
}

public class RXHUDSuccessView: RXHUDSquareBaseView, RXHUDAnimating {
    
    var checkmarkShapeLayer: CAShapeLayer = {
        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPointMake(8.0, 12))
        checkmarkPath.addLineToPoint(CGPointMake(15, 20))
        checkmarkPath.addLineToPoint(CGPointMake(36, 0.0))
        
        let layer = CAShapeLayer()
        layer.frame = CGRectMake(3.0, 3.0, 40, 25)
        layer.path = checkmarkPath.CGPath
        layer.fillMode = kCAFillModeForwards
        layer.lineCap     = kCALineCapRound
        layer.lineJoin    = kCALineJoinRound
        layer.fillColor   = nil
        layer.strokeColor = RXHUDHelper.sharedHUD.strokeColor.CGColor
        layer.lineWidth   = 2.0
        return layer
    }()
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(title: title, subtitle: subtitle)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(checkmarkShapeLayer)
        checkmarkShapeLayer.position = layer.position
    }
    
    public func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath:"strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.35
        
        checkmarkShapeLayer.addAnimation(checkmarkStrokeAnimation, forKey:"checkmarkStrokeAnim")
    }
    
    public func stopAnimation() {
        checkmarkShapeLayer.removeAnimationForKey("checkmarkStrokeAnimation")
    }
}

public class RXHUDTextView: UIView ,RXHUDAnimating{
    public init(text: String!) {
        let size : CGSize = RXHUDTextView.getTextRectSize(text, font: UIFont.systemFontOfSize(15))
        
        super.init(frame: CGRectMake(0, 0, size.width + 20, size.height + 20))
        commonInit(text)
    }
    
    class func getTextRectSize(text:NSString,font:UIFont) -> CGSize {
        let size = CGSizeMake(200, UIScreen.mainScreen().bounds.height)
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    
    convenience init() {
        self.init()
        self.hidden = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("")
    }
    
    func commonInit(text: String?) {
        titleLabel.text = text
        addSubview(titleLabel)
        
        let padding: CGFloat = 10.0
        titleLabel.frame = CGRectInset(bounds, padding, 0)
    }
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = RXHUDHelper.sharedHUD.strokeColor
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    public func startAnimation() {}
    public func stopAnimation() {}
}

public final class RXHUDSystemActivityIndicatorView: RXHUDSquareBaseView, RXHUDAnimating {
    
    public init() {
        super.init(frame: RXHUDSquareBaseView.defaultSquareBaseViewFrame)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit () {
        backgroundColor = UIColor.clearColor()
        alpha = 0.8
        
        self.addSubview(activityIndicatorView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = self.center
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activity.color = RXHUDHelper.sharedHUD.strokeColor
        return activity
    }()
    
    func startAnimation() {
        activityIndicatorView.startAnimating()
    }
    public func stopAnimation() {
        activityIndicatorView.startAnimating()
    }
}

public class RXHUDErrorView: RXHUDSquareBaseView, RXHUDAnimating {
    
    var dashOneLayer = RXHUDErrorView.generateDashLayer(true)
    var dashTwoLayer = RXHUDErrorView.generateDashLayer(false)
    
    class func generateDashLayer(upgrade: Bool = false) -> CAShapeLayer {
        let dash = CAShapeLayer()
        dash.frame = CGRectMake(0.0, 0.0, 88.0, 88.0)
        dash.path = {
            let rate :CGFloat = 0.35
            let path = UIBezierPath()
            if upgrade {
                path.moveToPoint(CGPointMake(88.0 * rate, 88.0 * rate))
                path.addLineToPoint(CGPointMake(88.0 * (1-rate), 88.0 * (1-rate)))
            } else {
                path.moveToPoint(CGPointMake(88.0 * (1-rate), 88.0 * rate))
                path.addLineToPoint(CGPointMake(88.0 * rate, 88.0 * (1-rate)))
            }

            return path.CGPath
            }()
        dash.lineCap     = kCALineCapRound
        dash.lineJoin    = kCALineJoinRound
        dash.fillColor   = nil
        dash.strokeColor = RXHUDHelper.sharedHUD.strokeColor.CGColor
        dash.lineWidth   = 2
        dash.fillMode    = kCAFillModeForwards
        return dash
    }
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(title: title, subtitle: subtitle)
        layer.addSublayer(dashOneLayer)
        layer.addSublayer(dashTwoLayer)
        dashOneLayer.position = layer.position
        dashTwoLayer.position = layer.position
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.addSublayer(dashOneLayer)
        layer.addSublayer(dashTwoLayer)
        dashOneLayer.position = layer.position
        dashTwoLayer.position = layer.position
    }
    
    
    public func startAnimation() {
        let checkmarkStrokeAnimation = CAKeyframeAnimation(keyPath:"strokeEnd")
        checkmarkStrokeAnimation.values = [0, 1]
        checkmarkStrokeAnimation.keyTimes = [0, 1]
        checkmarkStrokeAnimation.duration = 0.25
        dashTwoLayer.strokeEnd = 0.0
        checkmarkStrokeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        dashOneLayer.addAnimation(checkmarkStrokeAnimation, forKey:"checkmarkStrokeAnim")
        delay(0.25) { () -> Void in
            self.dashTwoLayer.addAnimation(checkmarkStrokeAnimation, forKey:"checkmarkStrokeAnim")
        }
        
        delay(0.45) { () -> Void in
            self.dashTwoLayer.strokeEnd = 1.0
        }
    }
    
    public func stopAnimation() {
        dashOneLayer.removeAnimationForKey("checkmarkStrokeAnimation")
        dashTwoLayer.removeAnimationForKey("checkmarkStrokeAnimation")
    }
}

public class RXHUDRotatingImageView: RXHUDSquareBaseView, RXHUDAnimating {
    
    func startAnimation() {
        imageView.layer.addAnimation(RXHUDAnimation.continuousRotation, forKey: "progressAnimation")
    }
    
    func stopAnimation() {
    }
}

public class RXHUDProgressView: RXHUDSquareBaseView, RXHUDAnimating {
    
    public init(title: String? = nil, subtitle: String? = nil) {
        super.init(image: RXHUDAssets.progressActivityImage, title: title, subtitle: subtitle)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func startAnimation() {
        imageView.layer.addAnimation(RXHUDAnimation.discreteRotation, forKey: "progressAnimation")
    }
    
    func stopAnimation() {
    }
}

public final class RXHUDAnimation {
    
    static let discreteRotation: CAAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [
            NSNumber(float: 0.0),
            NSNumber(float: 1.0 * Float(M_PI) / 6.0),
            NSNumber(float: 2.0 * Float(M_PI) / 6.0),
            NSNumber(float: 3.0 * Float(M_PI) / 6.0),
            NSNumber(float: 4.0 * Float(M_PI) / 6.0),
            NSNumber(float: 5.0 * Float(M_PI) / 6.0),
            NSNumber(float: 6.0 * Float(M_PI) / 6.0),
            NSNumber(float: 7.0 * Float(M_PI) / 6.0),
            NSNumber(float: 8.0 * Float(M_PI) / 6.0),
            NSNumber(float: 9.0 * Float(M_PI) / 6.0),
            NSNumber(float: 10.0 * Float(M_PI) / 6.0),
            NSNumber(float: 11.0 * Float(M_PI) / 6.0),
            NSNumber(float: 2.0 * Float(M_PI))
        ]
        animation.keyTimes = [
            NSNumber(float: 0.0),
            NSNumber(float: 1.0 / 12.0),
            NSNumber(float: 2.0 / 12.0),
            NSNumber(float: 3.0 / 12.0),
            NSNumber(float: 4.0 / 12.0),
            NSNumber(float: 5.0 / 12.0),
            NSNumber(float: 0.5),
            NSNumber(float: 7.0 / 12.0),
            NSNumber(float: 8.0 / 12.0),
            NSNumber(float: 9.0 / 12.0),
            NSNumber(float: 10.0 / 12.0),
            NSNumber(float: 11.0 / 12.0),
            NSNumber(float: 1.0)
        ]
        animation.duration = 1.2
        animation.calculationMode = "discrete"
        animation.repeatCount = Float(INT_MAX)
        return animation
    }()
    
    
    static let continuousRotation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2.0 * M_PI
        animation.duration = 1.2
        animation.repeatCount = Float(INT_MAX)
        return animation
    }()
}

public class RXHUDSquareBaseView: UIView {
    
    static let defaultSquareBaseViewFrame = CGRect(origin: CGPointZero, size: CGSize(width: 100.0, height: 100.0))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(image: UIImage? = nil, title: String? = nil, subtitle: String? = nil) {
        super.init(frame: RXHUDSquareBaseView.defaultSquareBaseViewFrame)
        self.imageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.alpha = 0.85
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleToFill
        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(15.0)
        label.textColor = RXHUDHelper.sharedHUD.strokeColor
        return label
    }()
    
    public let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = RXHUDHelper.sharedHUD.strokeColor
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth = bounds.size.width
        let viewHeight = bounds.size.height
        
//        let halfHeight = CGFloat(ceilf(CFloat(viewHeight / 2.0)))
        let quarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0)))
        let threeQuarterHeight = CGFloat(ceilf(CFloat(viewHeight / 4.0 * 3.0)))
        
        titleLabel.frame = CGRect(origin: CGPointZero, size: CGSize(width: viewWidth, height: quarterHeight))
        imageView.frame = CGRect(origin: CGPoint(x:(viewWidth - 40) * 0.5, y:(viewHeight - 40) * 0.5), size: CGSize(width: 40, height: 40))
        subtitleLabel.frame = CGRect(origin: CGPoint(x:0.0, y:threeQuarterHeight - 5), size: CGSize(width: viewWidth, height: quarterHeight))
    }
    
    deinit {
        print("RXHUDSquareBaseView:")
    }
}

public class RXHUDAssets: NSObject {
    
    public class var crossImage: UIImage { return RXHUDAssets.bundledImage(named: "cross") }
    public class var checkmarkImage: UIImage { return RXHUDAssets.bundledImage(named: "checkmark") }
    public class var progressActivityImage: UIImage { return RXHUDAssets.bundledImage(named: "progress_activity") }
    public class var progressCircularImage: UIImage { return RXHUDAssets.bundledImage(named: "progress_circular") }
    
    internal class func bundledImage(named name: String) -> UIImage {
        let bundle = NSBundle(forClass: RXHUDAssets.self)
        let image = UIImage(named: name, inBundle:bundle, compatibleWithTraitCollection:nil)
        if let image = image {
            return image
        }
        
        return UIImage()
    }
}
