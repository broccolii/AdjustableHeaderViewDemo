//
//  AdjustableHeaderView.swift
//  AdjustableHeaderViewDemo
//
//  Created by Broccoli on 15/11/24.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit

protocol AdjustableHeaderViewDelegate: class {
    func didScorllMaxOffset(maxOffset: CGFloat)
    func adjustNaviBarAplha(alpha: CGFloat)
}

class AdjustableHeaderView: UIView {
    var contentView = UIView()
    var adjustNaviBarAplha = true
    
    var subview: UIView
    var maxOffset: CGFloat
    
    weak var delegate: AdjustableHeaderViewDelegate!
    
    private let originY: CGFloat = -64.0
    
    // MARK: - 初始化方法
    init(inView: UIView, headerViewSize: CGSize, maxOffsetY: CGFloat, delegate: AdjustableHeaderViewDelegate) {
        
        subview = inView
        maxOffset = -abs(maxOffsetY)
        self.delegate = delegate
        
        super.init(frame: CGRectMake(0, 0, headerViewSize.width, headerViewSize.height))
        inView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        contentView.frame = self.bounds
        contentView.addSubview(inView)
        contentView.clipsToBounds = true
        addSubview(contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutHeaderView(offset: CGPoint) {
        if offset.y < maxOffset {
            delegate.didScorllMaxOffset(maxOffset)
        } else if offset.y < 0 {
            var rect = CGRectMake(0, 0, bounds.size.width, bounds.size.height)
            rect.origin.y += offset.y ;
            rect.size.height -= offset.y;
            contentView.frame = rect;
        }
        
        if adjustNaviBarAplha {
            let alpha = CGFloat((-originY + offset.y) / (self.frame.size.height))
            delegate.adjustNaviBarAplha(alpha)
        }
    }
}
