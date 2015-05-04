//
//  AlignAndDistribute.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 04/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class AlignAndDistribute: UIViewController
{
    let mainGroup = SLVGroup()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        view.addSubview(mainGroup)
        
        mainGroup.margin = 20
        
        let leftAlignedHGroup = SLHGroup()
        leftAlignedHGroup.children = [YellowBox(), UIView()]
        
        let centreAlignedHGroup = SLHGroup()
        centreAlignedHGroup.children = [UIView(), YellowBox(), UIView()]
        
        let rightAlignedHGroup = SLHGroup()
        rightAlignedHGroup.children = [UIView(), YellowBox()]
        
        let distributedHGroup = SLHGroup()
        distributedHGroup.children = [YellowBox(), UIView(), YellowBox(), UIView(), YellowBox(), UIView(), YellowBox()]
        
        let edgesHGroup = SLHGroup()
        edgesHGroup.children = [YellowBox(), UIView(), YellowBox()]
        
        mainGroup.children = [leftAlignedHGroup, centreAlignedHGroup, rightAlignedHGroup, distributedHGroup, edgesHGroup]
    }
    
    override func viewDidLayoutSubviews()
    {
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainGroup.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 5, dy: 0)
    }
}

class YellowBox: UIView, SLLayoutItem
{
    var percentageSize: CGFloat?
    var explicitSize: CGFloat? = 100
    
    override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        
        backgroundColor = UIColor.yellowColor()
    }
}
