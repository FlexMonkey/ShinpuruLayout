//
//  LabelledSegmentedControl.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 01/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class LabelledSegmentedControl: UIControl
{
    let labelWidget = UILabel()
    let segmentedControl: UISegmentedControl
    
    let vGroup = SLVGroup()
    
    required init(items: [AnyObject], label: String)
    {
        segmentedControl = UISegmentedControl(items: items)
        
        super.init(frame: CGRectZero)
        
        segmentedControl.addTarget(self, action: "segmentedControlChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        
        labelWidget.text = label
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview()
    {
        addSubview(vGroup)
        vGroup.children = [labelWidget, segmentedControl]
    }
    
    func segmentedControlChangeHandler()
    {
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    override var enabled: Bool
    {
        didSet
        {
            UIView.animateWithDuration(0.2, animations: {self.alpha = self.enabled ? 1 : 0.5})
        }
    }
    
    var selectedSegmentIndex: Int
    {
        set
        {
            segmentedControl.selectedSegmentIndex = newValue
        }
        get
        {
            return segmentedControl.selectedSegmentIndex
        }
    }
    
    var label: String = ""
    {
        didSet
        {
            labelWidget.text = label
        }
    }
    
    override func layoutSubviews()
    {
        vGroup.frame = bounds
    }
    
}