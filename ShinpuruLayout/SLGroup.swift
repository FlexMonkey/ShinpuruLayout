//
//  SLGroup.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.

//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>

import UIKit

/// Horizontal Group
class SLHGroup: SLGroup
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        var currentOriginX: CGFloat = 0

        for (index: Int, child: UIView) in enumerate(children)
        {

            let percentageWidth = childPercentageSizes[index] / 100 * (frame.width - totalExplicitSize)
            let componentWidth: CGFloat = SLGroup.hasExplicitSize(child) ? (child as! SLLayoutItem).explicitSize! : percentageWidth
            
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
        super.layoutSubviews()
        
        var currentOriginY: CGFloat = 0
        
        for (index: Int, child: UIView) in enumerate(children)
        {
            let percentageHeight = childPercentageSizes[index] / 100 * (frame.height - totalExplicitSize)
            let componentHeight: CGFloat = SLGroup.hasExplicitSize(child) ? (child as! SLLayoutItem).explicitSize! : percentageHeight
            
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
            
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews()
    {
        children.map({ super.addSubview($0) })
        
        let layoutMetrics = SLGroup.calculateLayoutMetrics(children)
        
        totalExplicitSize = layoutMetrics.totalExplicitSize
        totalPercentages = layoutMetrics.totalPercentages
        childPercentageSizes = layoutMetrics.childPercentageSizes
    }
    
    var margin: CGFloat = 1
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    typealias LayoutMetrics = (totalPercentages: CGFloat, childPercentageSizes: [CGFloat], totalExplicitSize: CGFloat)
    
    class func calculateLayoutMetrics(children: [UIView]) -> LayoutMetrics
    {
        var returnValue: LayoutMetrics
        
        returnValue.totalExplicitSize = children.filter({ self.hasExplicitSize($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).explicitSize!});
        
        returnValue.totalPercentages = children.filter({ self.hasPercentage($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).percentageSize!})
        
        let defaultComponentPercentage = (CGFloat(100) - returnValue.totalPercentages) / CGFloat(children.filter({ !self.hasPercentage($0) && !self.hasExplicitSize($0) }).count)
        
        returnValue.childPercentageSizes = children.map({ self.hasPercentage($0) ? ($0 as! SLLayoutItem).percentageSize! : defaultComponentPercentage })
        
        return returnValue
    }
    
    class func hasExplicitSize(value: UIView) -> Bool
    {
        return (value as? SLLayoutItem)?.explicitSize != nil && !hasPercentage(value)
    }
    
    class func hasPercentage(value: UIView) -> Bool
    {
        return (value as? SLLayoutItem)?.percentageSize != nil
    }
}
