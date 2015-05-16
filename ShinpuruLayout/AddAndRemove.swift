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
    let rowsGroup = SLVGroup()
    let toolbarGroup = SLHGroup()
    
    let removeRowButton = HorizontalRow.borderedButton("Remove Row", explicitSize: 200)
    let addRowButton = HorizontalRow.borderedButton("Add Row", explicitSize: 200)
    
    override func viewDidLoad()
    {
        view.backgroundColor = UIColor.blackColor()
        view.addSubview(mainGroup)
        
        mainGroup.margin = 10
        rowsGroup.margin = 10
        toolbarGroup.margin = 10
        
        toolbarGroup.explicitSize = 40
        
        mainGroup.addChild(toolbarGroup, atIndex: 0)
        mainGroup.addChild(rowsGroup, atIndex: 0)
        
        toolbarGroup.addChild(removeRowButton, atIndex: 0)
        toolbarGroup.addChild(addRowButton, atIndex: 0)
        
        let horizontalRow = HorizontalRow()
        rowsGroup.addChild(horizontalRow, atIndex: 0)
        horizontalRow.addClickHandler()
        horizontalRow.addClickHandler()
        
        removeRowButton.addTarget(self, action: "removeClickHandler", forControlEvents: UIControlEvents.TouchUpInside)
        addRowButton.addTarget(self, action: "addClickHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func addClickHandler()
    {
        rowsGroup.addChild(HorizontalRow(), atIndex: 0)
    }
    
    func removeClickHandler()
    {
        rowsGroup.removeChild(atIndex: 0)
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 0)
    }
    
}

class HorizontalRow: SLHGroup
{
    let removeButton = HorizontalRow.borderedButton("Remove")
    let addButton = HorizontalRow.borderedButton("Add")
    
    required init()
    {
        super.init()
        
        children = [addButton, removeButton]
        
        margin = 10
        
        removeButton.addTarget(self, action: "removeClickHandler", forControlEvents: UIControlEvents.TouchUpInside)
        addButton.addTarget(self, action: "addClickHandler", forControlEvents: UIControlEvents.TouchUpInside)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    func addClickHandler()
    {
        let box = UIView()
        box.backgroundColor = UIColor.yellowColor()
        
        addChild(box, atIndex: 2)
    }
    
    func removeClickHandler()
    {
        removeChild(atIndex: 2)
    }
    
    class func borderedButton(text: String, explicitSize: CGFloat = 100) -> SLButton
    {
        let button = SLButton()
        button.setTitle(text, forState: UIControlState.Normal)
        
        button.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        
        button.layer.cornerRadius = 3
        button.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.borderWidth = 1
        
        button.explicitSize = explicitSize
        
        return button
    }

}
