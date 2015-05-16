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
public class SLHGroup: SLGroup
{
    override public func layoutSubviews()
    {
        super.layoutSubviews()

        let childMetrics = SLGroup.calculateChildMetrics(children: children, childPercentageSizes: childPercentageSizes, availableSize: frame.width, totalExplicitSize: totalExplicitSize)
        
        map(zip(children, childMetrics))
        {
            $0.frame = CGRect(x: $1.origin, y: 0, width: $1.size, height: self.frame.height).rectByInsetting(dx: self.margin / 2, dy: 0)
        }
    }
}


/// Vertical Group
public class SLVGroup: SLGroup
{
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        
        let childMetrics = SLGroup.calculateChildMetrics(children: children, childPercentageSizes: childPercentageSizes, availableSize: frame.height, totalExplicitSize: totalExplicitSize)
        
        map(zip(children, childMetrics))
        {
            $0.frame = CGRect(x: 0, y: $1.origin, width: self.frame.width, height: $1.size).rectByInsetting(dx: 0, dy: self.margin / 2)
        }
    }
}

/// Base Class
public class SLGroup: UIView, SLLayoutItem
{
    public var percentageSize: CGFloat?
    public var explicitSize: CGFloat?
    
    private var childPercentageSizes = [CGFloat]()
    private var totalExplicitSize: CGFloat = 0
    
    typealias LayoutMetrics = (childPercentageSizes: [CGFloat], totalExplicitSize: CGFloat)
    typealias ChildMetric = (origin: CGFloat, size: CGFloat)
        
    override public func addSubview(view: UIView)
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
    
    override public func layoutSubviews()
    {
        children.map({ super.addSubview($0) })
        
        let layoutMetrics = SLGroup.calculateLayoutMetrics(children)
        
        totalExplicitSize = layoutMetrics.totalExplicitSize
        childPercentageSizes = layoutMetrics.childPercentageSizes
        
        if newChild != nil
        {
            dispatch_async(dispatch_get_main_queue(), addStep)
            
        }
        else if removeChildIndex != nil
        {
            dispatch_async(dispatch_get_main_queue(), removeStep)
        }
        else
        {
            getNextAnimation()
        }
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
        let totalExplicitSize = children.filter({ self.hasExplicitSize($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).explicitSize!});
        
        let totalPercentages = children.filter({ self.hasPercentage($0) }).reduce(CGFloat(0), combine: {$0 + ($1 as! SLLayoutItem).percentageSize!})
        
        let defaultComponentPercentage = (CGFloat(100) - totalPercentages) / CGFloat(children.filter({ !self.hasPercentage($0) && !self.hasExplicitSize($0) }).count)
        
        let childPercentageSizes = children.map({ self.hasPercentage($0) ? ($0 as! SLLayoutItem).percentageSize! : defaultComponentPercentage })
        
        return (childPercentageSizes, totalExplicitSize)
    }
    
    
    
    /// Returns an array of ChildMetric instances that define absolute position and width
    /// to fit within totalExplicitSize
    class func calculateChildMetrics(#children: [UIView], childPercentageSizes: [CGFloat], availableSize: CGFloat, totalExplicitSize: CGFloat) -> [ChildMetric]
    {
        var currentOrigin: CGFloat = 0

        let returnArray = map(zip(children, childPercentageSizes))
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

    // MARK: Animated add and remove....
    
    typealias SLGroupAnimationQueueItem = (type: SLAnimationType, index: Int, child: UIView?)
    
    private var animationQueueItems: [SLGroupAnimationQueueItem] = [SLGroupAnimationQueueItem]()
    
    private  let addChildSpacer = SLSpacer(percentageSize: nil, explicitSize: 0)
    private var newChildIndex: Int?
    private var removeChildIndex: Int?
    private var newChild: UIView?
    private var newExplicitSize: CGFloat?
    private var sizeStep: CGFloat?
    private var animationRunning: Bool = false
    
    func getNextAnimation()
    {
        if let nextAnim = animationQueueItems.first
        {
            nextAnim.type == .Add
                ? addChild(nextAnim.child!, atIndex: nextAnim.index)
                : removeChild(atIndex: nextAnim.index)
            
            animationQueueItems.removeAtIndex(0)
        }
    }
    
    func removeChild(#atIndex: Int)
    {
        if animationRunning
        {
            animationQueueItems.append( SLGroupAnimationQueueItem(.Remove, atIndex, nil) )
            return
        }
        else if atIndex >= children.count
        {
            return
        }
        
        animationRunning = true
        
        let layoutMetrics = SLGroup.calculateLayoutMetrics(children)
        totalExplicitSize = layoutMetrics.totalExplicitSize
        childPercentageSizes = layoutMetrics.childPercentageSizes
        let childMetrics = SLGroup.calculateChildMetrics(children: children, childPercentageSizes: childPercentageSizes, availableSize: frame.width, totalExplicitSize: totalExplicitSize)
        
        addChildSpacer.explicitSize = childMetrics[atIndex].size
        removeChildIndex = atIndex
        
        sizeStep = addChildSpacer.explicitSize! / 20
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {self.children[atIndex].alpha = 0}, completion: {(_) in self.children[atIndex] = self.addChildSpacer; self.removeStep()})
    }
    
    func addChild(child: UIView, atIndex: Int)
    {
        if animationRunning
        {
            if animationQueueItems.filter({ $0.child == child }).count == 0
            {
                animationQueueItems.append( SLGroupAnimationQueueItem(.Add, atIndex, child) )
            }
            return
        }
        
        animationRunning = true
        
        let targetIndex = min(children.count, atIndex)
        
        addChildSpacer.explicitSize = 0
        children.insert(addChildSpacer, atIndex: targetIndex)
        newChildIndex = targetIndex
        newChild = child
        newChild?.alpha = 0
        
        var candidateChildren = children
        candidateChildren.insert(child, atIndex: targetIndex)
        let layoutMetrics = SLGroup.calculateLayoutMetrics(candidateChildren)
        totalExplicitSize = layoutMetrics.totalExplicitSize
        childPercentageSizes = layoutMetrics.childPercentageSizes
        let childMetrics = SLGroup.calculateChildMetrics(children: candidateChildren, childPercentageSizes: childPercentageSizes, availableSize: frame.width, totalExplicitSize: totalExplicitSize)
        
        newExplicitSize = childMetrics[targetIndex].size
        sizeStep = newExplicitSize! / 20
        
        addStep()
    }
    
    private func removeStep()
    {
        if removeChildIndex != nil && addChildSpacer.explicitSize > 0
        {
            addChildSpacer.explicitSize! = addChildSpacer.explicitSize! - sizeStep!
        }
        else if removeChildIndex != nil
        {
            children.removeAtIndex(removeChildIndex!)
            
            removeChildIndex = nil
            animationRunning = false
        }
        
        setNeedsLayout()
    }
    
    private func addStep()
    {
        if newChild != nil && addChildSpacer.explicitSize < newExplicitSize
        {
            addChildSpacer.explicitSize! = addChildSpacer.explicitSize! + sizeStep!
        }
        else if newChild != nil
        {
            children[newChildIndex!] = newChild!
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {newChild?.alpha = 1}, completion: nil)
            
            animationRunning = false
            newChild = nil
        }
        
        setNeedsLayout()
    }
    
}

enum SLAnimationType
{
    case Add
    case Remove
}
