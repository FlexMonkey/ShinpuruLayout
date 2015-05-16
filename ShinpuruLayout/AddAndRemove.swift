//
//  AddAndRemove.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 13/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class AddAndRemove: UIViewController {

    let mainGroup = SLVGroup()
    let dynamicGroup = SLHGroup()
    
    override func viewDidLoad()
    {
        view.backgroundColor = UIColor.grayColor()
        
        mainGroup.frame = CGRect(x: 200, y: 200, width: 500, height: 200)
        
        let buttonsGroup = SLHGroup()
        
        let addButton = UIButton()
        addButton.addTarget(self, action: "addHandler", forControlEvents: UIControlEvents.TouchDown)
        addButton.setTitle("Add", forState: UIControlState.Normal)
        
        let removeButton = UIButton()
        removeButton.addTarget(self, action: "removeHandler", forControlEvents: UIControlEvents.TouchDown)
        removeButton.setTitle("Remove", forState: UIControlState.Normal)
        
        buttonsGroup.children = [addButton, removeButton]
        
        dynamicGroup.children = [createSLLabel("AAA"), createSLLabel("BBB")]
        
        mainGroup.children = [dynamicGroup, buttonsGroup]
        
        view.addSubview(mainGroup)
    }

    func removeHandler()
    {
        dynamicGroup.removeChild(atIndex: 0)
        dynamicGroup.removeChild(atIndex: 0)
        dynamicGroup.removeChild(atIndex: 0)
    }
    
    var foo = 1
    
    func addHandler()
    {
        for _ in 0 ... 2
        {
            let xyzzy = SLLabel()
            
            xyzzy.text = "\(foo++)"
            xyzzy.backgroundColor = UIColor.redColor()
            dynamicGroup.addChild(xyzzy, atIndex: 1)
        }

    }
    
    func createSLLabel(text: String, percentageSize: CGFloat? = nil, explicitSize: CGFloat? = nil) -> SLLabel
    {
        let label = SLLabel()
        label.layer.backgroundColor = UIColor.purpleColor().CGColor
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.textColor = UIColor.whiteColor()
        label.percentageSize = percentageSize
        label.explicitSize = nil
        return label
    }
    
}
