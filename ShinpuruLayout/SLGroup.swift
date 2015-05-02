//
//  SLGroup.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

/// Horizontal Group
class SLHGroup: SLGroup
{
    override func layoutSubviews()
    {
        let componentWidth = frame.width / CGFloat(children.count)
        
        for (index: Int, child: UIView) in enumerate(children)
        {
            let childX = CGFloat(index) * componentWidth
            
            child.frame = CGRect(x: childX, y: 0, width: componentWidth, height: frame.height).rectByInsetting(dx: margin / 2, dy: 0)
        }
    }
}

/// Vertical Group
class SLVGroup: SLGroup
{
    override func layoutSubviews()
    {
        let componentHeight = frame.height / CGFloat(children.count)
        
        for (index: Int, child: UIView) in enumerate(children)
        {
            let childY = CGFloat(index) * componentHeight
            
            child.frame = CGRect(x: 0, y: childY, width: frame.width, height: componentHeight).rectByInsetting(dx: 0, dy: margin / 2)
        }
    }
}

/// Base Class
class SLGroup: UIView
{
    var children: [UIView] = [UIView]()
    {
        didSet
        {
            oldValue.map({ $0.removeFromSuperview() })
            
            children.map({ self.addSubview($0) })
            
            setNeedsLayout()
        }
    }
    
    var margin: CGFloat = 0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
}