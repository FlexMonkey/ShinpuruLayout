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
            let percentageWidth = childPercentageSizes[index] / 100 * (frame.width - totalExplicitSize)
            let componentWidth: CGFloat = hasExplicitSize(child) ? (child as! SLLayoutItem).explicitSize! : percentageWidth
            
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
            let percentageHeight = childPercentageSizes[index] / 100 * (frame.height - totalExplicitSize)
            let componentHeight: CGFloat = hasExplicitSize(child) ? (child as! SLLayoutItem).explicitSize! : percentageHeight
            
            child.frame = CGRect(x: 0, y: currentOriginY, width: frame.width, height: componentHeight).rectByInsetting(dx: 0, dy: margin / 2)
            
            currentOriginY += componentHeight
        }
    }
}

/// Base Class
class SLGroup: UIView, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat?
    
    private var totalPercentages: CGFloat = 0
    private var childPercentageSizes = [CGFloat]()
    
    private var totalExplicitSize: CGFloat = 0
    
    override func addSubview(view: UIView)
    {
        children.append(view)
    }

    var children: [UIView] = [UIView]()
    {
        didSet
        {
            oldValue.map({ $0.removeFromSuperview() })
            
            children.map({ super.addSubview($0) })
            
            totalExplicitSize = children.filter({ hasExplicitSize($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).explicitSize!});
            
            totalPercentages = children.filter({ hasPercentage($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).percentageSize!})
            
            let defaultComponentPercentage = (CGFloat(100) - totalPercentages) / CGFloat(children.filter({ !hasPercentage($0) && !hasExplicitSize($0) }).count)

            childPercentageSizes = children.map({ hasPercentage($0) ? ($0 as! SLLayoutItem).percentageSize! : defaultComponentPercentage })

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

func hasExplicitSize(value: UIView) -> Bool
{
    return (value as? SLLayoutItem)?.explicitSize != nil && !hasPercentage(value)
}

func hasPercentage(value: UIView) -> Bool
{
    return (value as? SLLayoutItem)?.percentageSize != nil
}
