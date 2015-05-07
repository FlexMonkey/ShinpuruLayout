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

        let childMetrics = SLGroup.calculateChildMetrics(children: children, childPercentageSizes: childPercentageSizes, availableSize: frame.width, totalExplicitSize: totalExplicitSize)
        
        Array(zip(children, childMetrics)).map({
            $0.frame = CGRect(x: $1.origin, y: 0, width: $1.size, height: self.frame.height).rectByInsetting(dx: self.margin / 2, dy: 0)
            })
    }
}


/// Vertical Group
class SLVGroup: SLGroup
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        let childMetrics = SLGroup.calculateChildMetrics(children: children, childPercentageSizes: childPercentageSizes, availableSize: frame.height, totalExplicitSize: totalExplicitSize)
        
        Array(zip(children, childMetrics)).map({
            $0.frame = CGRect(x: 0, y: $1.origin, width: self.frame.width, height: $1.size).rectByInsetting(dx: 0, dy: self.margin / 2)
            })
    }
}


/// Base Class
class SLGroup: UIView, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat?
    
    private var childPercentageSizes = [CGFloat]()
    private var totalExplicitSize: CGFloat = 0
    
    typealias LayoutMetrics = (childPercentageSizes: [CGFloat], totalExplicitSize: CGFloat)
    typealias ChildMetric = (origin: CGFloat, size: CGFloat)
    
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
        childPercentageSizes = layoutMetrics.childPercentageSizes
    }
    
    var margin: CGFloat = 1
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    /// Returns a LayoutMetrics instance containing the percemtage sizes for each child and the total of the
    /// explicit sizes.
    class func calculateLayoutMetrics(children: [UIView]) -> LayoutMetrics
    {
        var returnValue: LayoutMetrics
        
        returnValue.totalExplicitSize = children.filter({ self.hasExplicitSize($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).explicitSize!});
        
        let totalPercentages = children.filter({ self.hasPercentage($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).percentageSize!})
        
        let defaultComponentPercentage = (CGFloat(100) - totalPercentages) / CGFloat(children.filter({ !self.hasPercentage($0) && !self.hasExplicitSize($0) }).count)
        
        returnValue.childPercentageSizes = children.map({ self.hasPercentage($0) ? ($0 as! SLLayoutItem).percentageSize! : defaultComponentPercentage })
        
        return returnValue
    }
    
    
    
    /// Returns an array of ChildMetric instances that define absolute position and width
    /// to fit within totalExplicitSize
    class func calculateChildMetrics(#children: [UIView], childPercentageSizes: [CGFloat], availableSize: CGFloat, totalExplicitSize: CGFloat) -> [ChildMetric]
    {
        var currentOrigin: CGFloat = 0

        let returnArray = Array(zip(children, childPercentageSizes)).map
        {
            (child, childPercentage) -> ChildMetric in
                let percentageWidth = childPercentage / 100 * (availableSize - totalExplicitSize)
                let componentWidth: CGFloat = SLGroup.hasExplicitSize(child) ? (child as! SLLayoutItem).explicitSize! : percentageWidth
                let previous = currentOrigin
                currentOrigin += componentWidth
                
                return ChildMetric(origin: previous, size: componentWidth)
        }
        
        return returnArray
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
