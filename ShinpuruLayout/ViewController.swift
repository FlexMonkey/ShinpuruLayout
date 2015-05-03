//
//  ViewController.swift
//  ShinpuruLayout
//
//  Created by Simon Gladman on 02/05/2015.
//  Copyright (c) 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let hGroupA = SLHGroup()
    let hGroupB = SLHGroup()
    let hGroupC = SLHGroup()
    let hGroupD = SLHGroup()
    
    let vGroup = SLVGroup()
    
    // For this demo, UILabels are orange
    func createUILabel(text: String) -> UILabel
    {
        let label = UILabel()
        label.layer.backgroundColor = UIColor.orangeColor().CGColor
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        
        return label
    }
    
    // For this demo, SLLabels are purple
    func createSLLabel(text: String, percentage: CGFloat?) -> SLLabel
    {
        let label = SLLabel()
        label.layer.backgroundColor = UIColor.purpleColor().CGColor
        label.textAlignment = NSTextAlignment.Center
        label.text = text
        label.percentage = percentage
        return label
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // a...
        for i: Int in 1 ... 10
        {
            hGroupA.children.append(createUILabel("idx: \(i)"))
        }

        // b...
        for i: Int in [10, 20, 20, 40, 10]
        {
            hGroupB.children.append(createSLLabel("\(i)%", percentage: CGFloat(i)))
        }

        // c...
        for i: Int in [20, 15]
        {
            hGroupC.children.append(createSLLabel("\(i)%", percentage: CGFloat(i)))
        }
        for i: Int in 1 ... 3
        {
            hGroupC.children.append(createUILabel("idx: \(i)"))
        }
        for i: Int in [25]
        {
            hGroupC.children.append(createSLLabel("\(i)%", percentage: CGFloat(i)))
        }
        
        // d...
        for i: Int in 1 ... 4
        {
            hGroupD.children.append(createUILabel("idx: \(i)"))
        }
        hGroupD.children.insert(createSLLabel("auto %", percentage: nil), atIndex: 2)
        hGroupD.children.insert(createSLLabel("auto %", percentage: nil), atIndex: 4)
        
        hGroupA.percentage = 20
        hGroupB.percentage = nil
        hGroupC.percentage = 30
        hGroupD.percentage = 10
        
        vGroup.children = [hGroupA, hGroupB, hGroupC, hGroupD]
        
        view.addSubview(vGroup)
    }

    override func viewDidLayoutSubviews()
    {
        vGroup.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 250).rectByInsetting(dx: 20, dy: 20)
    }
}

