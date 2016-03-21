//
//  HudTableController.swift
//  RXProgressHUD
//
//  Created by ZP on 16/3/21.
//  Copyright © 2016年 ZP. All rights reserved.
//

import UIKit

class HudTableController : UITableViewController {
    
    var style : UIBlurEffectStyle = .Light
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Style", style: .Plain , target: self, action: "rightItemDidClicked")
    }
    
    func rightItemDidClicked() {
        style = style == .Dark ? .Light : .Dark
        RXHUDHelper.sharedHUD.style = style
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
            case 0:
                HUD.showSuccessWithView(self.view, anim: false)
            case 1:
                HUD.showSuccess()
            case 2:
                HUD.showSuccess("success!")
            case 3:
                HUD.show(true, duration: 0.25, delay: 1, content: .LabeledSuccess(title: "title", subtitle: "subtitle"))
            case 4:
                HUD.showError()
            case 5:
                HUD.showError("error!")
            case 6:
                HUD.show(true, duration: 0.25, delay: 1, content: .LabeledError(title: "title", subtitle: "subtitle"))
            case 7:
                HUD.show(.SystemActivity)
            case 8:
                HUD.show(.SystemActivity)
                delay(2, work: { () -> Void in
                    HUD.hideWithSuccess()
                })
            case 9:
                HUD.show(.SystemActivity)
                delay(2, work: { () -> Void in
                    HUD.hideWithError()
                })
            case 10:
                HUD.showText("texttexttexttext!")
            default:
                HUD.flash(.RotatingImage(RXHUDAssets.crossImage), delay: 5, completion: { (finish) -> Void in

                })
        }
    }
}
