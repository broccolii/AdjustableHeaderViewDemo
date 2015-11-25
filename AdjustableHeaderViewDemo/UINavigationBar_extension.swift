//
//  UINavigationBar_extension.swift
//  AdjustableNavigationBar
//
//  Created by Broccoli on 15/11/24.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit

var overlayKey: Void?
var emptyImageKey: Void?

extension UINavigationBar {
    var overlay: UIView? {
        set {
            objc_setAssociatedObject(self, &overlayKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &overlayKey) as? UIView
        }
    }
    
    var emptyImage: UIImage? {
        set {
            objc_setAssociatedObject(self, &emptyImageKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &emptyImageKey) as? UIImage
        }
    }
    
    /**
     添加一个遮罩
     
     - parameter backgroundColor: 颜色
     */
    func br_setBackgroundColor(backgroundColor: UIColor) {
        if overlay == nil {
            // 返回 下部阴影 的 图片设置 为 nil
            setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            shadowImage = UIImage()
            
            overlay = UIView(frame: CGRect(x: 0, y: -20, width: UIScreen.mainScreen().bounds.size.width, height: CGRectGetHeight(self.bounds) + 20))
            overlay!.userInteractionEnabled = false
            insertSubview(overlay!, atIndex: 0)
        }
        overlay!.backgroundColor = backgroundColor
    }
    
    /**
     设置子元素 的透明度
     
     - parameter alpha:
     */
    func br_setElementsAlpha(alpha: CGFloat) {
        if let leftSubviews = valueForKey("_leftViews") as? [UIView] {
            for subview in leftSubviews {
                subview.alpha = alpha
            }
        }
        
        if let rightSubviews = valueForKey("_rightViews") as? [UIView] {
            for subview in rightSubviews {
                subview.alpha = alpha
            }
        }
        
        if let titleView = valueForKey("_titleView") as? UIView {
            titleView.alpha = alpha
        }
        for subview in subviews {
            if subview.isKindOfClass(NSClassFromString("UINavigationItemView")!) {
                subview.alpha = alpha
            }
        }
    }
    
    /**
     设置 Y 的偏移
     
     - parameter translationY:
     */
    func br_setTranslationY(translationY: CGFloat) {
        transform = CGAffineTransformMakeTranslation(0, translationY)
    }
    
    /**
     重置
     */
    func br_reset() {
        setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        shadowImage = nil
        if let _ = overlay {
            overlay!.removeFromSuperview()
        }
        overlay = nil
    }
}

