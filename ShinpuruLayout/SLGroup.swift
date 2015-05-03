//
//  SLGroup.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
// TODO 
//  Create suite of UI components that implement SLLayoutItem
//  Support for alignment
//  Explicit width / height 
//  Spacer component

import UIKit

/// Horizontal Group
class SLHGroup: SLGroup
{
    override func layoutSubviews()
    {
        var currentOriginX: CGFloat = 0

        for (index: Int, child: UIView) in enumerate(children)
        {
            let componentWidth: CGFloat = childPercentageSizes[index] / 100 * frame.width
            
            child.frame = CGRect(x: currentOriginX, y: 0, width: componentWidth, height: frame.height).rectByInsetting(dx: margin / 2, dy: 0)
            
            currentOriginX += componentWidth
        }
    }
}

/// Vertical Group
class SLVGroup: SLGroup
{
    override func layoutSubviews()
    {
         var currentOriginY: CGFloat = 0
        
        for (index: Int, child: UIView) in enumerate(children)
        {
            let componentHeight: CGFloat = childPercentageSizes[index] / 100 * frame.height
            
            child.frame = CGRect(x: 0, y: currentOriginY, width: frame.width, height: componentHeight).rectByInsetting(dx: 0, dy: margin / 2)
            
            currentOriginY += componentHeight
        }
    }
}

/// Base Class
class SLGroup: UIView
{
    private var totalPercentages: CGFloat = 0
    private var childPercentageSizes = [CGFloat]()
    
    var children: [UIView] = [UIView]()
    {
        didSet
        {
            oldValue.map({ $0.removeFromSuperview() })
            
            children.map({ self.addSubview($0) })
            
            totalPercentages = children.filter({ $0 is SLLayoutItem }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).percentage})
            
            let defaultComponentPercentage = (CGFloat(100) - totalPercentages) / CGFloat(children.filter({ !($0 is SLLayoutItem) }).count)

            childPercentageSizes = children.map({ $0 is SLLayoutItem ? ($0 as! SLLayoutItem).percentage : defaultComponentPercentage })

            setNeedsLayout()
        }
    }
    
    var margin: CGFloat = 1
    {
        didSet
        {
            setNeedsLayout()
        }
    }
}
