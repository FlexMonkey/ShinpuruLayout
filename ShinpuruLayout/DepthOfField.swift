//
//  ViewController.swift
//  DepthOfFieldExplorer
//
//  Created by Simon Gladman on 30/04/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit
import SceneKit

class DepthOfField: UIViewController {
    
    let dofViewer = DepthOfFieldViewer()
    
    let creditLabel = UILabel()
    
    let distanceWidget = LabelledSegmentedControl(items: ["20", "40", "60", "80"], label: "Distance")
    let focalSizeWidget = LabelledSegmentedControl(items: ["0", "1", "2", "4", "8"], label: "Focal Size")
    let focalBlurWidget = LabelledSegmentedControl(items: ["1", "2", "4", "8", "16"], label: "Focal Blur Radius")
    let apertureWidget = LabelledSegmentedControl(items: ["f/2", "f/2.8", "f/4", "f/5.6", "f/8"], label: "Aperture")
    
    let fogStartWidget = LabelledSegmentedControl(items: ["0", "20", "40", "60", "80"], label: "Fog Start")
    let fogEndWidget = LabelledSegmentedControl(items: ["0", "20", "40", "60", "80"], label: "Fog End")
    let fogDensityExponentWidget = LabelledSegmentedControl(items: ["0", "1", "2"], label: "Fog Density Exponent")
    
    var widgets = [LabelledSegmentedControl]()
    
    let mainGroup = SLVGroup()
    let upperToolbar = SLHGroup()
    let lowerToolbar = SLHGroup()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        upperToolbar.margin = 5
        lowerToolbar.margin = 5
        upperToolbar.explicitSize = 50
        lowerToolbar.explicitSize = 50
        
        view.addSubview(mainGroup)
        mainGroup.children = [dofViewer, upperToolbar, lowerToolbar]
        
        initialiseWidget(apertureWidget, selectedIndex: 1, targetGroup: upperToolbar)
        initialiseWidget(focalBlurWidget, selectedIndex: 3, targetGroup: upperToolbar)
        initialiseWidget(focalSizeWidget, selectedIndex: 3, targetGroup: upperToolbar)
        initialiseWidget(distanceWidget, selectedIndex: 1, targetGroup: upperToolbar)
        
        initialiseWidget(fogStartWidget, selectedIndex: 0, targetGroup: lowerToolbar)
        initialiseWidget(fogEndWidget, selectedIndex: 0, targetGroup: lowerToolbar)
        initialiseWidget(fogDensityExponentWidget, selectedIndex: 1, targetGroup: lowerToolbar)
        
        dofViewer.scene?.fogColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0)
        
        creditLabel.textColor = UIColor.blueColor()
        creditLabel.textAlignment = NSTextAlignment.Right
        creditLabel.numberOfLines = 2
        creditLabel.text = "Simon Gladman | May 2015\nflexmonkey.blogspot.co.uk"
        lowerToolbar.addSubview(creditLabel)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        cameraPropertiesChange()
    }
    
    func initialiseWidget(widget: LabelledSegmentedControl, selectedIndex: Int, targetGroup: SLGroup)
    {
        targetGroup.addSubview(widget)
        widgets.append(widget)
        
        widget.selectedSegmentIndex = selectedIndex
        widget.addTarget(self, action: "cameraPropertiesChange", forControlEvents: .ValueChanged)
    }
    
    func cameraPropertiesChange()
    {
        let apertures: [CGFloat] = [1 / 2, 1 / 2.8, 1 / 4, 1 / 5.6, 1 / 8]
        let fogDistances: [CGFloat] = [0, 20, 40, 60, 80]
        
        widgets.map({ $0.enabled = false })
        
        SCNTransaction.begin()
        SCNTransaction.setAnimationDuration(1.0)
        SCNTransaction.setCompletionBlock({widgets.map({ $0.enabled = true })})
        
        dofViewer.camera.aperture = apertures[apertureWidget.selectedSegmentIndex]
        dofViewer.camera.focalSize = CGFloat([0, 1, 2, 4, 8][focalSizeWidget.selectedSegmentIndex])
        dofViewer.camera.focalBlurRadius = CGFloat([1, 2, 4, 8, 16][focalBlurWidget.selectedSegmentIndex])
        dofViewer.camera.focalDistance = CGFloat([20, 40, 60, 80][distanceWidget.selectedSegmentIndex])
        
        dofViewer.scene?.fogStartDistance = fogDistances[fogStartWidget.selectedSegmentIndex]
        dofViewer.scene?.fogEndDistance = fogDistances[fogEndWidget.selectedSegmentIndex]
        dofViewer.scene?.fogDensityExponent = CGFloat([0, 1, 2][fogDensityExponentWidget.selectedSegmentIndex])
        SCNTransaction.commit()
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
       mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 10, dy: 10)
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    
}
