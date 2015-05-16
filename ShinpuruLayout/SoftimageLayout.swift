//
//  SoftimageLayout.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 04/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class SoftimageLayout: UIViewController
{
    let mainGroup = SLVGroup()
    
    let verticalToolbarWidth = CGFloat(110)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        view.addSubview(mainGroup)
   
        mainGroup.children = [createTopToolbar(), createCentreGroup(), createBottomToolbar()]
    }
    
    func createCentreGroup() -> SLHGroup
    {
        let group = SLHGroup()
        group.margin = 5
        
        let workSpace = SLImageView()
        workSpace.backgroundColor = UIColor.darkGrayColor()
        workSpace.image = UIImage(named: "teapot.jpg")
        workSpace.contentMode = UIViewContentMode.ScaleAspectFit
    
        group.children = [createLeftToolbar(), workSpace, createRightToolbar()]
        
        return group
    }
    
    func createBottomToolbar() -> SLHGroup
    {
        let toolbar = SLHGroup()
        
        let fixedSpacer = SLSpacer(percentageSize: nil, explicitSize: verticalToolbarWidth)
        
        toolbar.children = [fixedSpacer, UISlider(), fixedSpacer]
        toolbar.explicitSize = 30
        
        return toolbar
    }
    
    func createLeftToolbar() -> SLVGroup
    {
        let toolbar = SLVGroup()
        toolbar.margin = 3
        
        let variableSpacer = SLSpacer(percentageSize: 100, explicitSize: nil)
        
        toolbar.children = [borderedButton("Get"), borderedButton("Save"), borderedButton("Duplicate"), borderedButton("Delete"), borderedButton("Show"), borderedButton("Info"), borderedButton("Display"), borderedButton("Material"), borderedButton("Texture"), borderedButton("Paint"), variableSpacer, borderedButton("Exit")]
        toolbar.explicitSize = verticalToolbarWidth
        
        return toolbar
    }
    
    func createRightToolbar() -> SLVGroup
    {
        let toolbar = SLVGroup()
        toolbar.margin = 3
        
        let variableSpacer = SLSpacer(percentageSize: 100, explicitSize: nil)
        let fixedSpacer = SLSpacer(percentageSize: nil, explicitSize: 30)
        
        toolbar.children = [borderedButton("Preferences"), borderedButton("Camera"), borderedButton("Light"), fixedSpacer, borderedButton("Scale"), borderedButton("Rotate"), borderedButton("Transform"), variableSpacer, borderedButton("Single"), borderedButton("Multi"), fixedSpacer, borderedButton("Select")]
        toolbar.explicitSize = verticalToolbarWidth
        
        return toolbar
    }
    
    func createTopToolbar() -> SLHGroup
    {
        let toolbar = SLHGroup()

        let fixedSpacer = SLSpacer(percentageSize: nil, explicitSize: verticalToolbarWidth)
        let variableSpacer = SLSpacer(percentageSize: 100, explicitSize: nil)
        
        let labelOne = labelWithText("Shinpuru Layout")
        let labelTwo = labelWithText("Model")
        let labelThree = labelWithText("Motion")
        let labelFour = labelWithText("Actor")
        let labelFive = labelWithText("Matter")
        
        toolbar.children = [fixedSpacer, labelOne, variableSpacer, labelTwo, labelThree, labelFour, labelFive, fixedSpacer]
        toolbar.explicitSize = 30
        
        return toolbar
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 0)
    }
    
    func borderedButton(text: String) -> SLButton
    {
        let button = SLButton()
        button.setTitle(text, forState: UIControlState.Normal)
        
        button.layer.cornerRadius = 3
        button.layer.backgroundColor = UIColor.darkGrayColor().CGColor
        button.layer.borderColor = UIColor.lightGrayColor().CGColor
        button.layer.borderWidth = 1
        
        button.explicitSize = 30
        
        return button
    }
    
    func labelWithText(text: String) -> SLLabel
    {
        let label = SLLabel()
        label.text = text
        
        label.textColor = UIColor.lightGrayColor()
        
        label.percentageSize = nil
        label.explicitSize = label.intrinsicContentSize().width + label.layoutMargins.left + label.layoutMargins.right
        
        return label
    }
}

